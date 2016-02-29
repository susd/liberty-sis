module ReportCards
  module Layouts

    class DefaultLayout < PdfReport::Document
      attr_reader :data

      def initialize(pdf_data)
        @data = pdf_data
        super()
      end

      # Section geometry

      def main_width
        canvas_width * 0.65
      end

      def side_width
        canvas_width * 0.35 - gutter
      end

      def main_rect
        @main_rect ||= PdfReport::Geometry::Rect.new(width: main_width, height: 610, x: 0, y: 700)
      end

      def heading_items
        I18n.t('report_card.defaults.heading_items')
      end

      def translated(&block)
        I18n.with_locale(data.home_locale, &block)
      end

      def render
        # build_header
        # build_legend
        # build_main
        build_footer
        document.render
      end

      def build_header
        # name / school details
      end

      def build_footer
        Components::Footer.new(self, data).render
      end

    end

  end
end
