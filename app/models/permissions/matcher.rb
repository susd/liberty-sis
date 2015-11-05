module Permissions
  class Matcher
    attr_reader :user, :resource

    def initialize(user)
      @user = user
    end

    def permissions
      @perms ||= Merger.resource_merge(user.roles.pluck(:permissions))
    end

    def match_general?(ability, level, resource)
      user_ability = resource_ability(resource)
      if user_ability >= Ability.new(ability)
        Level.new(permissions[resource.to_s][user_ability.to_s]) >= Level.new(level)
      else
        false
      end
    end

    def match_target?(ability, target)
      if permissions.empty?
        false
      else
        has_ability_over?(target) && sufficient_ability?(ability, resource)
      end
    end

    def has_ability_over?(target)
      resource_from_target(target)
      if permissions[resource].nil?
        false
      else
        level = permissions[resource][resource_ability(resource).to_s]
        self.send("match_#{level}_scope", target)
      end
    end

    def sufficient_ability?(ability, resource)
      user_ability = resource_ability(resource)
      user_ability >= Ability.new(ability)
    end

    def resource_ability(resource)
      if permissions[resource.to_s]
        Ability.new(permissions[resource.to_s].keys[0])
      else
        Ability.new # zero-rank Action
      end
    end

    def resource_level(resource)
      ability = resource_ability(resource)
      if permissions[resource.to_s] && permissions[resource.to_s][ability.to_s]
        Level.new(permissions[resource.to_s][ability.to_s])
      else
        Level.new
      end
    end

    def ability_for(target)
      resource_from_target(target)
      Ability.new permissions[resource].keys[0]
    end

    def target_in_level?(level, target)
      self.send("match_#{level}_scope", target)
    end

    def match_all_scope(target)
      resource_from_target(target)
      Level.new(:all) == resource_level(resource)
    end

    def match_site_scope(target)
      @user.sites.any? do |site|
        site.send(resource.to_sym).include? target
      end
    end

    def match_own_scope(target)
      resource = resource_from_target(target)
      @user.employee &&
      @user.employee.respond_to?(resource.to_sym) &&
      @user.employee.send(resource.to_sym).include?(target)
    end

    def match_self_scope(target)
      @user == target || @user.employee == target
    end

    def resource_from_target(target)
      @resource ||= target.class.table_name
    end

  end
end
