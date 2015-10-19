class BuildStudentPdfJob < ActiveJob::Base
  queue_as :pdf

  def perform(student)
    GenerateStudentCardPdf.new(student).perform!
  end
end
