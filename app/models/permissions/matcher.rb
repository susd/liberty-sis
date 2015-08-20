module Permissions
  class Matcher
    attr_reader :user, :resource

    def initialize(user)
      @user = user
    end

    def permissions
      @perms ||= Merger.new.resource_merge(user.roles.pluck(:permissions))
    end

    def match_general?(ability, level, resource)
      # what does user have for resource?
      # is ability >= ?
      # is level >= ?
    end

    def resource_ability(resource)
      if permissions[resource.to_s]
        Ability.new(permissions[resource.to_s].keys[0])
      else
        Ability.new # zero-rank Action
      end
    end

    def has_resource_ability?(resource)
      permissions[resource.to_s].keys.any?
    end

    def resource_level(resource)
      if has_resource_ability?(resource)
        Level.new permissions[resource.to_s].values[0]
      else
        Level.new
      end
    end

    def has_ability_over?(target)
      find_resource(target)
      permissions[resource].present?
    end

    def target_ability(target)
      find_resource(target)
      Ability.new permissions[resource].keys[0]
    end

    def target_level_match?(level, target)
      self.send("match_#{level}_scope", target)
    end

    def match_all_scope(target)
      find_resource(target)
      Level.new(:all) == resource_level(resource)
    end
    #
    # def match_site_scope
    #   @user.sites.any? do |site|
    #     site.send(resource.to_sym).include? target
    #   end
    # end

    def match_own_scope(target)
      resource = find_resource(target)
      @user.employee && @user.employee.send(resource.to_sym).include?(target)
    end

    # def match_self_scope
    #   @user == target || @user.employee == target
    # end

    def find_resource(target)
      @resource ||= target.class.table_name
    end

  end
end
