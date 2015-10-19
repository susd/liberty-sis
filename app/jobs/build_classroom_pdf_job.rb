class BuildClassroomPdfJob < ActiveJob::Base
  queue_as :pdf

  def perform(classroom)
    CombineClassroomPdfs.new(classroom).perform!
  end
end
