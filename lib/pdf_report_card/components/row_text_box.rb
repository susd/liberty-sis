module PdfReportCard
  module Components
    
    class RowTextBox
      def initialize(document, rect, content = nil, index = 0, options = {})
        @doc = document
        @rect = rect
        
        @content = content ||= [{text: ""}]
        
        @options = defaults(rect, index).merge(options)
      end
      
      def render
        @doc.formatted_text_box(@content, @options)
      end
      
      private
      
      def defaults(rect, index)
        {
          align: :center, 
          valign: :center, 
          at: [rect.x + (index * rect.w), rect.y], 
          width: rect.w, 
          height: rect.h
        }
      end
      
      def font_from_style(content)
        content.map do |c|
          if c.fetch(:styles, []).include?(:bold)
            c.merge({font: PdfReportCard::DEFAULT_BOLD_FONT})
          else
            c
          end
        end
      end
    end
    
  end
end