module Ischool
  module FormParsers
    
    class PrimaryParser < BaseParser
      include FormMaps::PrimaryCard
      
      def card_level
        'primary'
      end
    end
    
  end
end