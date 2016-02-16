module PdfReportCard
  module Layouts

    class Base
      include Prawn::View
      include Geometry

      def initialize(data = {})
        @row_count = 0
        @row_pos = 0
        self.line_width = PdfReportCard::BORDER_WEIGHTS[:normal]
        setup_font
        @data = data_defaults.merge(data)
      end

      def document
        @document ||= Prawn::Document.new(page_size: 'LETTER', margin: page_margin)
      end

      alias :doc :document

      def setup_font
        font_families.update("SourceSansPro" => {
          :normal => PdfReportCard::DEFAULT_FONT,
          :bold   => PdfReportCard::DEFAULT_BOLD_FONT,
          :italic => PdfReportCard::DEFAULT_ITALIC_FONT
        })
        font 'SourceSansPro'
        font_size PdfReportCard::DEFAULT_SIZE
      end

      def heading_items
        # [
        #   'Requires Additional Support',
        #   'Works Within Grade-Level Standards',
        #   'Demonstrates Strengths',
        #   'Effort'
        # ]
        I18n.t('report_card.defaults.heading_items')
      end

      def legend_title

      end

      def legend_items
        ["O - Outstanding", "G - Good", "S - Satisfactory", "N - Needs Improvement", "✓ - Quality of Work"]
      end

      def render_details(name, school, start_year)
        detail_size   = 13
        school_year   = "#{start_year} / #{start_year + 1}"
        student_rect  = Geometry::Rect.new(width: canvas_width, height: 2 * detail_size, x: 0, y: canvas_height)
        year_rect     = Geometry::Rect.new(width: canvas_width, height: 2 * detail_size, x: 0, y: canvas_height)
        school_rect   = Geometry::Rect.new(width: (canvas_width - 72), height: 2 * detail_size, x: 0, y: canvas_height)

        text_box name,        at: student_rect.coords,  width: student_rect.w,  size: detail_size, style: :bold
        text_box school_year, at: year_rect.coords,     width: year_rect.w,     size: detail_size, style: :bold, align: :right
        text_box school,      at: school_rect.coords,   width: school_rect.w,   size: detail_size, style: :normal, align: :right

        stroke_line([0, student_rect.bottom],[canvas_width, student_rect.bottom])
      end

      def render_title_address(title = "Progress Report Card")
        address  = "Saugus Union School District\n24930 Avenue Stanford\nSanta Clarita, CA 91355"
        text_box title,   at: [side_rect.x, legend_rect.y], width: side_rect.w, height: 34, style: :bold, size: 13
        text_box address, at: [side_rect.x, legend_rect.y - 34], width: side_rect.w, height: legend_rect.h - 26, leading: 2, size: 10
      end

      def render_legend(list = [], title = "Effort Grades\nWork and Study Habits", title_lines = 2)
        legend = PdfReportCard::Components::Legend.new(legend_rect, doc, title_lines: title_lines)
        legend.draw_border
        legend.write_title do |doc|
          doc.text title
        end
        legend.write_list do |doc|
          list.each do |item|
            doc.text item
          end
        end
      end

      def render_period_row(ordinals = ['1st', '2nd', '3rd', '4th'])
        period_row = PdfReportCard::Components::PeriodRow.new(period_rect, doc, count: 3, start_x: legend_rect.w, start_y: main_rect.y)
        period_row.render(ordinals)
      end

      def render_heading_row(headings)
        start_x = legend_rect.w # + (header_rect.w / 2) - (header_txt_font_size / 2)
        start_y = heading_rect.y # - header_rect.h + (header_txt_font_size / 2)
        PdfReportCard::Components::HeadingRow.new(heading_rect, doc, headings: headings, count: 12, start_x: start_x, start_y: start_y).render
      end

      def draw_page_lines
        stroke do
          main_rect.draw(doc)
          side_rect.draw(doc)
        end
      end

      def fill_page_areas
        fill_color "DDFFEE"
        main_rect.fill(doc)

        fill_color "DDEEFF"
        side_rect.fill(doc)

        fill_color "FFEEDD"
        footer_rect.fill(doc)
      end

      def render_header
        render_legend(legend_items)
        render_period_row
        render_heading_row(heading_items)
      end

      def render_footer(teacher_name = "", principal_name = "", grade = "", services = [])
        services_box = Geometry::Rect.new(x: footer_rect.x, y: footer_rect.y - (2 * gutter), width: footer_rect.w, height: 24)

        column_width = (footer_rect.w / 3) - (gutter / 1.5)

        first_column  = {x: footer_rect.x, y: services_box.bottom - gutter, width: column_width, height: 24}
        second_column = first_column.merge(x: footer_rect.x + column_width + gutter)
        third_column  = second_column.merge(x: second_column[:x] + column_width + gutter)

        teacher_box  = Geometry::Rect.new(first_column)
        admin_box    = Geometry::Rect.new(second_column)
        assigned_box = Geometry::Rect.new(third_column)

        adjusted_y = teacher_box.y + 2

        font(PdfReportCard::DEFAULT_BOLD_FONT) do
          text_box services.join(', '), at: [services_box.x, services_box.y + 12], width: services_box.w, height: services_box.h
          text_box teacher_name,  at: [teacher_box.x, teacher_box.y + 12],   width: teacher_box.w,   height: teacher_box.h
          text_box principal_name,  at: [admin_box.x, admin_box.y + 12],   width: admin_box.w,   height: admin_box.h
          text_box grade,  at: [assigned_box.x, assigned_box.y + 12],   width: assigned_box.w,   height: assigned_box.h
        end

        stroke_line([services_box.x,  services_box.y + 2],  [services_box.w, services_box.y + 2])
        stroke_line([services_box.x,  adjusted_y],          [teacher_box.right_top[0], adjusted_y])
        stroke_line([admin_box.x,     adjusted_y],          [admin_box.right_top[0], adjusted_y])
        stroke_line([assigned_box.x,  adjusted_y],          [assigned_box.right_top[0], adjusted_y])

        text_box "Additional Services", at: services_box.coords,  width: services_box.w,  height: services_box.h
        text_box "Teacher",             at: teacher_box.coords,   width: teacher_box.w,   height: teacher_box.h
        text_box "Administrator",       at: admin_box.coords,     width: admin_box.w,     height: admin_box.h
        text_box "Assigned To",         at: assigned_box.coords,  width: assigned_box.w,  height: assigned_box.h
      end

      def render_comments(comments = nil, lang = :english)
        return false if (comments.nil? || comments.none?)

        move_cursor_to comments_rect.y

        default_leading 8

        font(PdfReportCard::DEFAULT_BOLD_FONT, size: 13) do
          text (lang == :english ? "Comments" : "Comentarios")
        end

        font_size 10

        if comments['1'] && comments['1'].any?
          font(PdfReportCard::DEFAULT_BOLD_FONT) do
            text (lang == :english ? "First Grading Period" : "1er Período de Calificaciones")
          end

          comments['1'].each do |txt|
            text "• " + txt
          end
        end

        if comments['2'] && comments['2'].any?
          font(PdfReportCard::DEFAULT_BOLD_FONT) do
            text (lang == :english ? "Second Grading Period" : "2do Período de Calificaciones")
          end

          comments['2'].each do |txt|
            text "• " + txt
          end
        end

        if comments['3'] && comments['3'].any?
          font(PdfReportCard::DEFAULT_BOLD_FONT) do
            text (lang == :english ? "Third Grading Period" : "3er Período de Calificaciones")
          end

          comments['3'].each do |txt|
            text "• " + txt
          end
        end

        # reset font_size in case of spanish pages
        font_size PdfReportCard::DEFAULT_SIZE
        default_leading 0
      end

      def main_section(data, &block)
        options = {
          row_start: (legend_rect.y - legend_rect.h),
          label_width: legend_rect.w,
          rect: main_rect,
          data: data
        }

        build_section(options, &block)
      end

      def side_section(data, &block)
        options = {
          rect: side_rect,
          data: data,
          label_width: side_rect.w * 0.6
        }

        build_section(options, &block)
      end

      def build_section(options = {}, &block)
        section = Components::Section.new(document, options[:rect], options[:data], options)
        if block
          block.arity < 1 ? section.instance_eval(&block) : block[section]
        end
      end

      # SPANISH

      def render_spanish_header
        render_legend(spanish_legend_items, "Calificacion del Esfuerzo\nHabitos de Trabajo y Estudio", 3)
        render_period_row((1..3).map(&:to_s))
        render_heading_row(spanish_heading_items)
      end

      def spanish_legend_items
        ["O - Sobresaliente", "G - Bueno", "S - Satisfactorio", "N - Necesita Mejorar"]
      end

      def spanish_heading_items
        # [
        #   'Requiere Ayuda Adicional',
        #   'Trabaja al Nivel del Grado',
        #   'Demuestra Destreza',
        #   'Esfuerzo'
        # ]
        I18n.with_locale(:es) do
          I18n.t('report_card.defaults.heading_items')
        end
      end

      def render_spanish_footer(teacher_name = "", principal_name = "", grade = "", services = [])
        services_box = Geometry::Rect.new(x: footer_rect.x, y: footer_rect.y - (3 * gutter), width: footer_rect.w, height: 16)

        column_width = (footer_rect.w / 3) - (gutter / 1.5)

        first_column  = {x: footer_rect.x, y: services_box.bottom - gutter, width: column_width, height: 24}
        second_column = first_column.merge(x: footer_rect.x + column_width + gutter)
        third_column  = second_column.merge(x: second_column[:x] + column_width + gutter)

        teacher_box  = Geometry::Rect.new(first_column)
        admin_box    = Geometry::Rect.new(second_column)
        assigned_box = Geometry::Rect.new(third_column)

        adjusted_y = teacher_box.y + 2

        font(PdfReportCard::DEFAULT_BOLD_FONT) do
          text_box services.join(', '), at: [services_box.x, services_box.y + 12], width: services_box.w, height: services_box.h
          text_box teacher_name,  at: [teacher_box.x, teacher_box.y + 12],   width: teacher_box.w,   height: teacher_box.h
          text_box principal_name,  at: [admin_box.x, admin_box.y + 12],   width: admin_box.w,   height: admin_box.h
          text_box grade,  at: [assigned_box.x, assigned_box.y + 12],   width: assigned_box.w,   height: assigned_box.h
        end

        stroke_line([services_box.x, services_box.y + 2], [services_box.w, services_box.y + 2])
        stroke_line([services_box.x, adjusted_y], [teacher_box.right_top[0], adjusted_y])
        stroke_line([admin_box.x, adjusted_y], [admin_box.right_top[0], adjusted_y])
        stroke_line([assigned_box.x, adjusted_y], [assigned_box.right_top[0], adjusted_y])

        text_box "Servicios Adicionales", at: services_box.coords,  width: services_box.w,  height: services_box.h
        text_box "Firma del Maestro (a)",             at: teacher_box.coords,   width: teacher_box.w,   height: teacher_box.h
        text_box "Firma del Director",       at: admin_box.coords,     width: admin_box.w,     height: admin_box.h
        text_box "Asignado A",         at: assigned_box.coords,  width: assigned_box.w,  height: assigned_box.h
      end

      private

      def move_row_pos(delta = 0)
        if @row_count < 1
          @row_pos = legend_rect.y - legend_rect.h
        else
          @row_pos = @row_pos - delta
        end
        @row_count += 1
      end

      def data_defaults
        {
          "name"    => "No Name",
          "school"  => "School",
          "year"    => Time.now.year
        }
      end

    end # /Base

  end
end
