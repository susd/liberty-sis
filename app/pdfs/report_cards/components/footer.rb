module ReportCards
  module Components

    class Footer
      attr_reader :doc, :data

      delegate :font, :text_box, :stroke_line, :gutter, :main_rect, :canvas_width, to: :doc

      def initialize(layout, data)
        @doc  = layout
        @data = data
      end

      def render
        # text
        font(PdfReport::DEFAULT_BOLD_FONT) do
          text_box data.teacher_name, teacher_name_opts
          text_box data.principal_name, principal_name_opts
          text_box data.next_grade.to_s, next_grade_opts
        end

        # lines
        underlines.each do |line|
          stroke_line(*line)
        end

        # labels
        text_box "Additional Services", at: services_box.coords,  width: services_box.w,  height: services_box.h
        text_box "Teacher",             at: teacher_box.coords,   width: teacher_box.w,   height: teacher_box.h
        text_box "Administrator",       at: admin_box.coords,     width: admin_box.w,     height: admin_box.h
        text_box "Assigned To",         at: next_grade_box.coords,  width: next_grade_box.w,  height: next_grade_box.h
      end

      def outer_rect
        PdfReport::Geometry::Rect.new(width: canvas_width, height: 144, x: main_rect.x, y: main_rect.bottom - (gutter / 2))
      end

      def column_width
        (outer_rect.w / 3) - (gutter / 1.5)
      end

      def underlines
        adjusted_y = teacher_box.y + 2
        [
          [[services_box.x,  services_box.y + 2], [services_box.w, services_box.y + 2]],
          [[services_box.x,  adjusted_y], [teacher_box.right_top[0], adjusted_y]],
          [[admin_box.x,     adjusted_y], [admin_box.right_top[0], adjusted_y]],
          [[next_grade_box.x,  adjusted_y], [next_grade_box.right_top[0], adjusted_y]]
        ]
      end

      def teacher_name_opts
        {
          at: [teacher_box.x, teacher_box.y + 12],
          width: teacher_box.w,
          height: teacher_box.h
        }
      end

      def principal_name_opts
        {
          at: [admin_box.x, admin_box.y + 12],
          width: admin_box.w,
          height: admin_box.h
        }
      end

      def next_grade_opts
        {
          at: [next_grade_box.x, next_grade_box.y + 12],
          width: next_grade_box.w,
          height: next_grade_box.h
        }
      end

      def teacher_box
        PdfReport::Geometry::Rect.new(first_column)
      end

      def admin_box
        PdfReport::Geometry::Rect.new(second_column)
      end

      def next_grade_box
        PdfReport::Geometry::Rect.new(third_column)
      end

      def first_column
        {
          x: outer_rect.x, y: services_box.bottom - gutter,
          width: column_width, height: 24
        }
      end

      def second_column
        first_column.merge(x: outer_rect.x + column_width + gutter)
      end

      def third_column
        second_column.merge(x: second_column[:x] + column_width + gutter)
      end

      def services_box
        PdfReport::Geometry::Rect.new({
          x: outer_rect.x, y: outer_rect.y - (2 * gutter),
          width: outer_rect.w, height: 24
          })
      end


    end

  end
end
