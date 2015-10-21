module PdfReportCard
  module Components
    
    class HeadingRow < BoxRow
      
      def initialize(rect, document, headings: [], count: 12, start_x: 0, start_y: 0, padding: 6)
        @headings = headings
        @padding = padding
        super(rect, document, count: count, start_x: start_x, start_y: start_y)
      end
      
      def write_headings
        lbl_idx = 0

        @count.times do |i|
          pad = @padding
          
          hd_w = @rect.h - (2 * pad)
          hd_h = @rect.w
          hd_x = @start_x + pad + (i * @rect.w)
          hd_y = @rect.y - @rect.h + pad
          
          lbl = @headings[lbl_idx]
          
          if lbl.size > 30
            hd_x = hd_x - (pad / 2)
          end

          @doc.formatted_text_box(
            [{text: lbl}], 
            {at: [hd_x, hd_y], width: hd_w, height: hd_h, rotate: 90}
            )

          lbl_idx += 1
          if lbl_idx > @headings.size - 1
            lbl_idx = 0
          end
        end
      end
      
      def render
        draw_borders
        write_headings
      end
      
    end
    
  end
end