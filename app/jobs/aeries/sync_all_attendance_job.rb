module Aeries
  class SyncAllAttendanceJob < ActiveJob::Base
    queue_as :sync

    def perform(school_code)
      site = Site.find_by(code: school_code)
      site.classrooms.each do |c|
        Aeries::AttendanceImporter.import_classroom(c)
      end
    end
  end
end
