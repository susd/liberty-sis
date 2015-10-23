module ReportCards
  class RenderCardPdfJob < ActiveJob::Base
    queue_as :pdf

    def perform(report_card)
      ReportCard::CardGenerator.new(report_card).perform!
    end
  end
end
