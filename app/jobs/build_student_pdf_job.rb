class BuildStudentPdfJob < ActiveJob::Base
  queue_as :pdf

  def perform(student)
    ReportCard::StudentGenerator.new(student).perform!
  end
end
