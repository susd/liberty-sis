module Aeries
  class SyncAttendanceJob < ActiveJob::Base
    queue_as :pdf

    after_perform do
      SyncAttendanceJob.set(wait: 1.hour).perform_later
    end

    def perform
      Aeries::AttendanceImporter.import_recent!
    end
  end
end
