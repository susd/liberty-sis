module Aeries
  class SyncAttendanceJob < ActiveJob::Base
    queue_as :sync

    after_perform do
      SyncAttendanceJob.set(wait: 1.hour).perform_later
    end

    def perform
      if SyncEvent.where(label: 'attendance:recent').exists?
        since = SyncEvent.where(label: 'attendance:recent').maximum(:created_at)
      else
        since = 1.day.ago
      end
      Aeries::AttendanceImporter.import_recent!(since)
    end
  end
end
