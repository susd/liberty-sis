module Ischool
  module FormParsers
    
    class UpperParser < BaseParser
      include FormMaps::UpperCard
      
      def card_level
        'upper'
      end
      
      def parse_subjects
        @data.each do |k, v|
          if upper_card_map[k]
            sub_name, period, sub_key = upper_card_map[k].split('.')
            if subject = subject_lookup( sub_name )
              @result['subjects'][subject.id.to_s]['periods'][period][sub_key] = unescape(v)
            end
          end
        end
        @result
      end
      
    end #/class
    
  end
end