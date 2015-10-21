module PdfReportCard
  module Components
    
    class BoxRow
      
      def initialize(rect, document, count: 3, start_x: 0, start_y: 0, border_mask: [])
        @rect = rect
        @doc = document
        @count = count
        @start_x = start_x
        @start_y = start_y
        
        if border_mask.any?
          @border_mask = border_mask
        else
          @border_mask = [1] * count
        end
      end
      
      def draw_borders
        @count.times do |i|
          if @border_mask[i] == 1
            @doc.stroke_rectangle [@start_x + (i * @rect.w), @start_y], @rect.w, @rect.h
          end
        end
      end
      
      def render
        draw_borders
      end
      
    end
    
  end
end