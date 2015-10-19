module Ischool
  module FormParsers
    
    class KinderParser < BaseParser
      include FormMaps::KinderCard
      
      def card_level
        'kinder'
      end
    end
    
  end
end