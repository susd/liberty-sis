module PdfReportCard
  module Components
    
    class PeriodRow < BoxRow
      # ORDINALS = ['1st', '2nd', '3rd', '4th']
      
      def write_periods(ordinals)
        @count.times do |i|
          @doc.text_box ordinals[i], {align: :center, valign: :center, at: [@start_x + (i * @rect.w), @start_y], width: @rect.w, height: @rect.h}
        end
      end
      
      def render(ordinals = ['1st', '2nd', '3rd', '4th'])
        draw_borders
        write_periods(ordinals)
      end
      
    end
    
  end
end