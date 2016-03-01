module ReportCards
  module Components

    class Header
      attr_reader :doc, :data

      def initialize(layout, data)
        @doc = layout
        @data = data
      end

      def render
        # detail_size   = 13
        # school_year   = "#{start_year} / #{start_year + 1}"
        # student_rect  = Geometry::Rect.new(width: canvas_width, height: 2 * detail_size, x: 0, y: canvas_height)
        # year_rect     = Geometry::Rect.new(width: canvas_width, height: 2 * detail_size, x: 0, y: canvas_height)
        # school_rect   = Geometry::Rect.new(width: (canvas_width - 72), height: 2 * detail_size, x: 0, y: canvas_height)
        #
        # text_box name,        at: student_rect.coords,  width: student_rect.w,  size: detail_size, style: :bold
        # text_box school_year, at: year_rect.coords,     width: year_rect.w,     size: detail_size, style: :bold, align: :right
        # text_box school,      at: school_rect.coords,   width: school_rect.w,   size: detail_size, style: :normal, align: :right
        #
        # stroke_line([0, student_rect.bottom],[canvas_width, student_rect.bottom])
      end
    end

  end
end
