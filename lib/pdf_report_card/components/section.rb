module PdfReportCard
  module Components

    class Section

      attr_reader :doc, :data, :rect, :options

      def initialize(document, rect, data = {}, options = {})
        @doc      = document
        @rect     = rect
        @data     = data

        @options = defaults.merge(options)

        @row_count  = 0
        @row_pos    = 0
      end

      def add_policy(options = {})
        opts = policy_defaults.merge(options)
        @doc.formatted_text_box(opts[:policy], at: opts[:coords], width: opts[:width], height: opts[:height])
      end

      def add_table(data, options = {}, &block)
        opts = table_defaults.merge(options)
        table = @doc.make_table(data) do |tbl|
          block[tbl]
        end
        @doc.bounding_box(opts[:coords], {width: opts[:width], height: opts[:height]}) do
          table.draw
        end
      end

      private

      def policy_defaults
        {
          coords: [@rect.x, @rect.y - 425],
          width: @rect.w, height: 64,
          policy: [
            {text: "Policy Statement", styles: [:bold], size: 10},
            {text: "\n\nThe Board of Education will authorize retention of students based upon their school attendance. A total of twenty-five (25) excused or unexcused absences during a school year will be cause for retention."}
          ]
        }
      end

      def table_defaults
        {
          coords: @rect.coords,
          width: @rect.w, height: @rect.h
        }
      end

      def defaults
        {
          row_start: @rect.y,
          label_width: (@rect.w / 2)
        }
      end

    end

  end
end
