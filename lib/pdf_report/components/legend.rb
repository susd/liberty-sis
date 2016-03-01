module PdfReport
  module Components

    class Legend
      attr_reader :doc, :rect, :style, :title, :list

      def initialize(document, bounding_rect, style: {}, title: {}, list: {} )
        @doc  = document
        @rect = bounding_rect
        @style = default_style_opts.merge(style)
        @title = default_title_opts.merge(title)
        @list  = default_list_opts.merge(list)
      end

      def draw_outer_border
        rect.draw(doc)
      end

      def write_title(text)
        doc.text_box(text, title_rect.to_textbox.merge(style: :bold))
      end

      def write_list(items)
        text = items.join("\n")
        doc.text_box(text, list_rect.to_textbox.merge(size: list[:size]))
      end

      def title_rect
        @title_rect ||= Geometry::Rect.new({
          width: rect.padded_w(style[:padding]),
          height: (title[:lines] * title[:size]) + style[:padding],
          x: rect.x + style[:padding],
          y: rect.y - style[:padding]
          })
      end

      def list_rect
        @list_rect ||= Geometry::Rect.new({
          width: rect.padded_w(style[:padding]),
          height: rect.h - title_rect.h - (3 * style[:padding]),
          x: title_rect.x,
          y: title_rect.y - title_rect.h - style[:padding]
          })
      end

      private

      def default_style_opts
        { padding: 8 }
      end

      def default_title_opts
        {
          size: 8,
          lines: 1
        }
      end

      def default_list_opts
        { size: 8 }
      end
    end

  end
end
