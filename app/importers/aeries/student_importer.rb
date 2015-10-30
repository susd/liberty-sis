module Aeries

  class StudentImporter

    attr_reader :student

    def self.import_many(aeries_student_relation)
      aeries_student_relation.find_each do |stu|
        new(stu).import!
      end
    end

    def initialize(aeries_student)
      @student = aeries_student
    end

    def import!
      event = SyncEvent.create(label: 'student')

      attrs = student.to_student

      if exists?
        update_if_active(attrs)
      else
        @native = ::Student.create(attrs)
      end

      import_enrollments!
      import_attendance!

      event.update(state: 1, syncable: native)

      native
    end

    def import_if_fresh!
      if fresh?
        import!
      end

      native
    end

    def import_enrollments!
      enrollments.each do |enr|
        Aeries::EnrollmentImporter.new(enr).import!
      end
    end

    def import_attendance!
      Aeries::AttendanceImporter.new(student).import!
    end

    def native
      @native ||= find_native
    end

    def find_native
      ::Student.find_by(["import_details @> ?", student.import_ids.to_json])
    end

    def exists?
      native.present?
    end

    def fresh?
      return true if native.nil?

      aeries_stamp = student.dts
      last_import  = native.sync_events.maximum(:created_at)

      (aeries_stamp && last_import) && (aeries_stamp > last_import)
    end

    def enrollments
      @enrollments ||= student.enrollments
    end

    def reset_native_memberships
      native.classroom_memberships.destroy_all
      native.add_classroom(enrollments.active.first.liberty_classroom)
    end

    private

    def update_if_active(attrs)
      if student.active?
        native.update(attrs)
      end
    end

  end

end
