module PdfReport
  module Components

    class VerticalHeader
      attr_reader :doc, :rect, :cells

      def initialize(document, bounding_rect, cells: {})
        @doc  = document
        @rect = bounding_rect
        @cells = default_cell_opts.merge(style)
      end

      private

      def default_cell_opts
        { count: 12 }
      end
    end

  end
end
