module Permissions
  class Merger

    def self.resource_merge(array_of_resources)
      array_of_resources.inject({}) do |builder, res_hsh|
        builder.merge!(res_hsh) do |key, old_ability, new_ability|
          ability_merge([old_ability, new_ability])
        end
      end
    end

    def self.ability_merge(array_of_abilities)
      levels = array_of_abilities.flat_map{|hsh| hsh.values }.uniq
      if levels.size == 1
        array_of_abilities.sort{|a,b| Ability.new(a.keys[0]) <=> Ability.new(b.keys[0]) }.last
      else
        array_of_abilities.inject({}) do |builder, ability|
          builder.merge(ability) do |key, old_level, new_level|
            Level.new(old_level) < Level.new(new_level) ? new_level : old_level
          end
        end
      end
    end

  end
end
