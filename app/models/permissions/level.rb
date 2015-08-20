module Permissions
  class Level < Element
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
