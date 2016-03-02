module ReportCards
  module Components

    class Legend
      attr_reader :layout, :data

      def initialize(layout, data)
        @layout = layout
        @data = data
      end

      def render
        legend = PdfReport::Components::Legend.new(layout, layout.legend_rect, title: {lines: 2})
        legend.draw_outer_border
        legend.write_title(title)
        legend.write_list(items)
      end

      def title
        I18n.t('report_card.defaults.legend_title')
      end

      def items
        I18n.t('report_card.defaults.legend_items')
      end
    end

  end
end
