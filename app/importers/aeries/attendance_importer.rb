module Aeries
  class AttendanceImporter

    def self.import_classroom(classroom)
      classroom.students.each do |student|
        if a = student.aeries_student
          new(a).import!
        end
      end
    end

    def self.import_recent!(since = nil)
      since = since || ::Attendance.maximum(:created_at)
      students = Aeries::Student.active
        .joins("INNER JOIN ATT on STU.sc = ATT.sc AND STU.sn = ATT.sn")
        .where("ATT.dts > ?", since)
      students.find_each do |student|
        new(student).import!
      end
    end

    attr_reader :student, :year
    attr_accessor :range

    def initialize(aeries_student, year = nil, range = nil)
      @student = aeries_student
      @year  = year || ReportCard::GradingPeriod.school_year
      @range = range || ReportCard::GradingPeriod.current_year_range
    end

    def import!
      attendance_scope.each do |att|
        native_attendance = ::Attendance.find_by(["import_details -> 'import_ids' = ?", [att.sc, att.sn, att.dy].to_json])
        if native_attendance.nil?
          native_attendance = ::Attendance.new
        end
        native_attendance.assign_attributes(att_attrs(att))
        native_attendance.save
      end
    end

    def attendance_scope
      student.attendances.confirmed.where(dt: @range)
    end

    private

    def att_attrs(attendance)
      {
        student: find_native_student,
        date: attendance.attributes['dt'],
        day: attendance.attributes['dy'],
        kind: attendance.simple,
        import_details: {
          import_ids: [attendance.sc, attendance.sn, attendance.dy]
        }
      }
    end

    def find_native_student
      ::Student.find_by(["import_details -> 'import_id' = ?", student.attributes['id'].to_json])
    end

  end
end
