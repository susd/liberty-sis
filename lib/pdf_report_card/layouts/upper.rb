module PdfReportCard
  module Layouts
    
    class Upper < PdfReportCard::Layouts::Base
      
      def main_width
        canvas_width * 0.6
      end
    
      def side_width
        canvas_width * 0.4 - gutter
      end
      
      def main_rect
        @main_rect ||= Rect.new(width: main_width, height: 540, x: 0, y: 700)
      end
      
      def legend_rect
        @legend_rect ||= Rect.new(width: (main_rect.w * 0.6), height: 80, y: main_rect.y)
      end
      
      def title_addr_rect
        @title_rect ||= Rect.new(width: side_width, height: legend_rect.h, x: main_rect.w + gutter, y: main_rect.y)
      end
  
      def period_rect
        Rect.new(width: (main_rect.w - legend_rect.w) / 3, height: 12)
      end
  
      def heading_rect
        Rect.new(width: (main_rect.w - legend_rect.w) / 6, height: legend_rect.h - period_rect.h, y: main_rect.y - period_rect.h)
      end
      
      def heading_items
        ['Achievement', 'Effort']
      end
      
      def legend_items
        [
          "A - Outstanding",
          "B - Good",
          "C - Satisfactory",
          "N - Needs Improvement",
          "+ - Area of Strength",
          "✓ - Area of Concern"
        ]
      end
      
      def render_legend(list = [], title = "Effort Grades\nWork and Study Habits", title_lines = 2)
        legend_col_1 = Rect.new(width: (legend_rect.w / 2), height: legend_rect.h, x: legend_rect.x, y: legend_rect.y)
        legend_col_2 = Rect.new(width: legend_col_1.w, height: legend_rect.h, x: legend_col_1.w, y: legend_rect.y)
        legend_a = PdfReportCard::Components::Legend.new(legend_col_1, doc)
        legend_b = PdfReportCard::Components::Legend.new(legend_col_2, doc)
        
        # legend_a.draw_border
        legend_a.write_title do |doc|
          doc.text "Achievement"
        end
        legend_a.write_list do |doc|
          text "A - Outstanding"
          text "B - Good"
          text "C - Satisfactory"
          text "N - Needs Improvement"
          text "+ - Area of Strength"
          text "✓ - Area of Concern"
        end
        
        # legend_b.draw_border
        legend_b.write_title do |doc|
          doc.text "Effort"
        end
        legend_b.write_list do |doc|
          text "O - Outstanding"
          text "S - Satisfactory"
          text "N - Needs Improvement"
          text "U - Unsatisfactory"
          text "+ - Area of Strength"
          text "✓ - Area of Concern"
        end
        
      end
      
      def render_heading_row(headings)
        start_x = legend_rect.w # + (header_rect.w / 2) - (header_txt_font_size / 2)
        start_y = heading_rect.y # - header_rect.h + (header_txt_font_size / 2)
        PdfReportCard::Components::HeadingRow.new(heading_rect, doc, headings: headings, count: 6, start_x: start_x, start_y: start_y).render
      end
      
      def build_header(&block)
        header = PdfReportCard::Builders::HeadingBuilder.new
        header.instance_eval(&block) if block_given?
      end
      
      # SPANISH
      
      def spanish_heading_items
        ['Logro Académico', 'Esfuerzo']
      end
      
      def render_spanish_legend(list = [])
        legend_col_1 = Rect.new(width: (legend_rect.w / 2), height: legend_rect.h, x: legend_rect.x, y: legend_rect.y)
        legend_col_2 = Rect.new(width: legend_col_1.w, height: legend_rect.h, x: legend_col_1.w, y: legend_rect.y)
        legend_a = PdfReportCard::Components::Legend.new(legend_col_1, doc)
        legend_b = PdfReportCard::Components::Legend.new(legend_col_2, doc)
        
        # legend_a.draw_border
        legend_a.write_title do |doc|
          doc.text "Logro"
        end
        legend_a.write_list do |doc|
          text "A - Sobresaliente"
          text "B - Bueno"
          text "C - Satisfactorio"
          text "N - Necesita Mejorar"
          text "+ - Area de Destreza"
          text "✓ - Area Que Nos Preocupa"
        end
        
        # legend_b.draw_border
        legend_b.write_title do |doc|
          doc.text "Esfuerzo"
        end
        legend_b.write_list do |doc|
          text "O - Sobresaliente"
          text "S - Satisfactorio"
          text "N - Necesita Mejorar"
          text "U - Poco Satisfactorio"
          text "+ - Area de Destreza"
          text "✓ - Area Que Nos Preocupa"
        end
        
      end
      
    end
    
  end
end