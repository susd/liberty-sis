module Ischool
  module FormParsers
    
    class TkParser < BaseParser
      include FormMaps::TkCard
      
      def card_level
        'tk'
      end
    end
    
  end
end