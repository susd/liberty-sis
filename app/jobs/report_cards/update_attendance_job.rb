module ReportCards
  class UpdateAttendanceJob < ActiveJob::Base
    queue_as :report_cards

    after_perform do |job|
      UpdateAttendanceJob.set(wait: 12.hours).perform_later(*job.arguments)
    end

    def perform(school_code)
      site = Site.find_by(code: school_code)
      site.classrooms.each do |c|
        c.current_cards.each do |r|
          r.update_attendance
          r.save
        end
      end
    end
    
  end
end
