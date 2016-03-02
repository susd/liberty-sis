module ReportCards
  module Components

    class SubjectHeader
      attr_reader :layout, :data

      def initialize(layout, data)
        @layout = layout
        @data = data
      end

      def render
        # render_period_row
        # period_row = PdfReportCard::Components::PeriodRow.new(period_rect, doc, count: 3, start_x: legend_rect.w, start_y: main_rect.y)
        # period_row.render(ordinals)

        # render_heading_row(heading_items)
        # start_x = legend_rect.w # + (header_rect.w / 2) - (header_txt_font_size / 2)
        # start_y = heading_rect.y # - header_rect.h + (header_txt_font_size / 2)
        # PdfReportCard::Components::HeadingRow.new(heading_rect, doc, headings: headings, count: 12, start_x: start_x, start_y: start_y).render
      end


    end

  end
end
