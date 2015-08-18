module Permissions
  class Matcher
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def permissions
      @perms ||= Merger.new.resource_merge(user.roles.pluck(:permissions))
    end

    def resource_ability(resource)
      if permissions[resource.to_s]
        Ability.new(permissions[resource.to_s].keys[0])
      else
        Ability.new # zero-rank Action
      end
    end

    def target_ability(target)
      # if permissions
    end

    # def match_all_scope
    #   true
    # end
    #
    # def match_site_scope
    #   @user.sites.any? do |site|
    #     site.send(resource.to_sym).include? target
    #   end
    # end
    #
    # def match_own_scope
    #   @user.employee && @user.employee.send(resource.to_sym).include?(target)
    # end
    #
    # def match_self_scope
    #   @user == target || @user.employee == target
    # end

  end
end
