module ReportCards
  module Layouts

    class DefaultLayout < PdfReport::Document
      attr_reader :data

      def initialize(pdf_data)
        @data = pdf_data
        super()
      end

      def heading_items
        I18n.t('report_card.defaults.heading_items')
      end

      def translated(&block)
        I18n.with_locale(data.home_locale, &block)
      end

      def render
        build_heading
        build_main
        build_footer
        # document.render
      end

      def build_heading
        # -- Name / School / Year
        # -- Legend
        # -- Title / address
      end

    end

  end
end
