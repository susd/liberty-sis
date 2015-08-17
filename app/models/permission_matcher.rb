# User has ability for resource
# Ability is higher than requirement
# Target is in scope

class PermissionMatcher
  attr_reader :user, :requirement, :resource, :target

  def self.match(user, requirement, target)
    new(user, requirement, target).match?
  end

  def initialize(user, requirement, target)
    @user = user
    @requirement = requirement
    @target = target
    @resource = target.class.table_name
  end

  def match?
    if permissions.empty?
      false
    else
      has_ability_over_target?
    end
  end

  def permissions
    @perms ||= resource_merge( user.roles.pluck(:permissions) )
  end

  def resource_ability
    if permissions[resource]
      @resource_ability ||= Action.new(permissions[resource].keys[0])
    else
      Action.new # zero-rank Action
    end
  end

  def meets_requirement?
    Action.new(requirement) <= resource_ability
  end

  def has_ability_over_target?
    if permissions[resource].nil?
      false
    else
      level = permissions[resource][resource_ability.to_s]
      self.send("match_#{level}_scope")
    end
  end

  def ability_merge(array_of_abilities)
    levels = array_of_abilities.flat_map{|hsh| hsh.values }.uniq
    if levels.size == 1
      array_of_abilities.sort{|a,b| Action.new(a.keys[0]) <=> Action.new(b.keys[0]) }.last
    else
      array_of_abilities.inject({}) do |builder, ability|
        builder.merge(ability) do |key, old_level, new_level|
          Level.new(old_level) < Level.new(new_level) ? new_level : old_level
        end
      end
    end
  end

  def resource_merge(array_of_resources)
    array_of_resources.inject({}) do |builder, res_hsh|
      builder.merge!(res_hsh) do |key, old_ability, new_ability|
        ability_merge([old_ability, new_ability])
      end
    end
  end

  def match_all_scope
    true
  end

  def match_site_scope
    @user.sites.any? do |site|
      site.send(resource.to_sym).include? target
    end
  end

  def match_own_scope
    @user.employee && @user.employee.send(resource.to_sym).include?(target)
  end

  def match_self_scope
    @user == target || @user.employee == target
  end

  class Action
    include Comparable
    attr_accessor :ability

    def initialize(ability = nil)
      @ability = ability.nil? ? nil : ability.to_sym
    end

    def name
      ability
    end

    def to_s
      name.to_s
    end

    def <=>(other)
      rank <=> other.rank
    end

    def rank
      if ability.nil?
        0
      else
        ability_rank.index(ability)
      end
    end

    private

    def ability_rank
      %i{none view edit manage}
    end
  end

  class Level
    include Comparable
    attr_accessor :level

    def initialize(level = nil)
      @level = level.nil? ? nil : level.to_sym
    end

    def <=>(other)
      rank <=> other.rank
    end

    def rank
      if level.nil?
        0
      else
        level_rank.index(level)
      end
    end

    private

    def level_rank
      %i{none self own site all}
    end
  end
end
