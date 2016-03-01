module ReportCards
  module Components

    class Header
      attr_reader :doc, :data

      def initialize(layout, data)
        @doc = layout
        @data = data
      end

      def render
        doc.text_box student_name, at: student_rect.coords,  width: student_rect.w,  size: font_size, style: :bold
        doc.text_box school_year,  at: year_rect.coords,     width: year_rect.w,     size: font_size, style: :bold, align: :right
        doc.text_box school_name,  at: school_rect.coords,   width: school_rect.w,   size: font_size, style: :normal, align: :right

        doc.stroke_line([0, student_rect.bottom],[doc.canvas_width, student_rect.bottom])
      end

      def font_size
        13
      end

      def student_name
        data.student_name
      end

      def school_year
        data.school_year.to_s
      end

      def school_name
        data.school_name
      end

      def student_rect
        PdfReport::Geometry::Rect.new({
          width: doc.canvas_width,
          height: 2 * font_size,
          x: 0,
          y: doc.canvas_height
          })
      end

      def year_rect
        PdfReport::Geometry::Rect.new({
          width: doc.canvas_width,
          height: 2 * font_size,
          x: 0,
          y: doc.canvas_height
          })
      end

      def school_rect
        PdfReport::Geometry::Rect.new({
          width: (doc.canvas_width - 72),
          height: 2 * font_size,
          x: 0,
          y: doc.canvas_height
          })
      end


    end

  end
end
