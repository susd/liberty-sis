module PdfReport
  module Components

    class VerticalHeader
      attr_reader :doc, :rect, :cells

      def initialize(document, bounding_rect, cells: {})
        @doc  = document
        @rect = bounding_rect
        @cells = default_cell_opts.merge(cells)
      end

      def draw_outer_border
        rect.draw(doc)
      end

      def write_headings(headings)
        text_idx = 0

        cells[:count].times do |i|
          text = headings[text_idx]

          doc.formatted_text_box(
            [{text: text}],
            {
              at: [text_x(i, text), text_y],
              width: text_w, height: text_h,
              rotate: 90
            }
          )

          text_idx += 1
          if text_idx > headings.size - 1
            text_idx = 0
          end
        end

      end

      def cell_width
        rect.w / cells[:count]
      end

      def text_w
        rect.h - (2 * cells[:padding])
      end

      def text_h
        cell_width
      end

      def text_x(idx, text)
        x = rect.x + cells[:padding] + (idx * text_h)
        if text.size > 30
          x = x - (cells[:padding] / 2)
        end
        x
      end

      def text_y
        rect.y - rect.h + cells[:padding]
      end
      
      private

      def default_cell_opts
        { count: 12, padding: 6 }
      end

    end

  end
end
