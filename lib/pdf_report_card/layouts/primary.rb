module PdfReportCard
  module Layouts

    class Primary < PdfReportCard::Layouts::Base

      def legend_items
        [
          "O - Outstanding",
          "G - Good", "S - Satisfactory",
          "N - Needs Improvement",
          "U - Unsatisfactory",
          "✓ - Quality of Work"
        ]
      end
    end

  end
end
