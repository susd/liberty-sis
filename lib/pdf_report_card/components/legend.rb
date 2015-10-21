module PdfReportCard
  module Components
    
    class Legend
      attr_writer :title
      def initialize(rect, document, padding: 6, title_size: 8, list_size: 8, title_lines: 1)
        @rect = rect
        @doc = document
        @title_size = title_size
        @title_lines = title_lines
        @list_size = list_size
        @padding = padding
        
        # @title = "Effort Grades\nWork and Study Habits"
        
        build_title_rect(padding, title_size)
        build_list_rect(padding, list_size)
      end
      
      def draw_border
        @rect.draw(@doc)
      end
      
      def draw_borders
        @doc.bounding_box(*@rect.to_bb) do
          @title_rect.draw(@doc)
          @list_rect.draw(@doc)
        end
      end
      
      def build_title_rect(padding, size)
        title_w = @rect.padded_w(padding)
        title_h = (@title_lines * size) + padding
        title_x = padding
        title_y = @rect.h - padding
        
        @title_rect = Geometry::Rect.new(width: title_w, height: title_h, x: title_x, y: title_y)
      end
      
      def build_list_rect(padding, size)
        list_w = @rect.padded_w(padding)
        list_h = @rect.h - @title_rect.h - (3 * padding)
        list_x = @title_rect.x
        list_y = @title_rect.y - @title_rect.h - padding
        
        @list_rect = Geometry::Rect.new(width: list_w, height: list_h, x: list_x, y: list_y)
      end
      
      def write_title(&block)
        @doc.bounding_box(*@rect.to_bb) do
          @doc.bounding_box(*@title_rect.to_bb) do
            @doc.font_size @title_size
            @doc.font PdfReportCard::DEFAULT_BOLD_FONT
            block.call(@doc)
            @doc.font PdfReportCard::DEFAULT_FONT, style: :normal
            @doc.font_size PdfReportCard::DEFAULT_SIZE
          end
        end
      end
      
      def write_list(&block)
        @doc.bounding_box(*@rect.to_bb) do
          @doc.bounding_box(*@list_rect.to_bb) do
            @doc.font_size @list_size
            block.call(@doc)
            @doc.font_size PdfReportCard::DEFAULT_SIZE
          end
        end
      end
      
    end
    
  end
end