module ReportCards
  class SweepPdfsJob < ActiveJob::Base
    queue_as :pdf

    after_perform do
      SweepPdfsJob.set(wait: 3.hours).perform_later
    end

    def perform
      PdfSweeper.perform!
    end
  end
end
