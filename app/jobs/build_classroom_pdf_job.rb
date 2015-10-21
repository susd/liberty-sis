class BuildClassroomPdfJob < ActiveJob::Base
  queue_as :pdf

  def perform(classroom)
    ReportCard::ClassroomCombiner.new(classroom).perform!
  end
end
