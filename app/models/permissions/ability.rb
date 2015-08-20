module Permissions
  class Ability < Element
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
end
