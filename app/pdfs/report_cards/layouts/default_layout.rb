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
        @main_rect ||= PdfReport::Geometry::Rect.new({
          width: main_width, height: 610, x: 0, y: 700
          })
      end

      def title_addr_rect
        @title_rect ||= PdfReport::Geometry::Rect.new({
          width: side_width, height: 80,
          x: main_rect.w + gutter, y: main_rect.y
          })
      end

      def side_rect
        @side_rect ||= PdfReport::Geometry::Rect.new({
          width: side_width,
          height: (main_rect.h - title_addr_rect.h),
          x: title_addr_rect.x,
          y: main_rect.y - title_addr_rect.h
          })
      end

      def legend_rect
        @legend_rect ||= PdfReport::Geometry::Rect.new({
          width: 110, height: 130, y: main_rect.y
          })
      end

      def heading_items
        I18n.t('report_card.defaults.heading_items')
      end

      def translated(&block)
        I18n.with_locale(data.home_locale, &block)
      end

      def render
        build_page_header
        build_title
        build_address
        build_legend
        # build_main
        build_footer
        document.render
      end

      def build_page_header
        Components::PageHeader.new(self, data).render
      end

      def build_title
        text_box data.title, {
          at: [side_rect.x, legend_rect.y],
          width: side_rect.w,
          height: 34,
          style: :bold,
          size: 13
        }
      end

      def build_address
        text_box data.address, {
          at: [side_rect.x, legend_rect.y - 34],
          width: side_rect.w,
          height: legend_rect.h - 26,
          leading: 2,
          size: 10
        }
      end

      def build_legend

      end

      def build_footer
        Components::Footer.new(self, data).render
      end

    end

  end
end
