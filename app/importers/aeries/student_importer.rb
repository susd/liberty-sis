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
      event = SyncEvent.create(label: 'aeries:student')

      attrs = student.to_student

      if exists?
        native.update(attrs)
      else
        @native = ::Student.create(attrs)
      end

      import_enrollments!
      import_attendance!
      import_contacts!
      reset_native_classrooms

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
      # set all enrollments inactive
      # set current enrollment active
    end

    def import_attendance!
      Aeries::AttendanceImporter.new(student).import!
    end

    def import_contacts!
      Aeries::HomeContactImporter.new(student).import!
      Aeries::ContactImporter.for_student(native)
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

    def purge_imported_memberships
      native.classroom_memberships.imported.destroy_all
    end

    def set_native_homeroom
      native.homeroom = native_homeroom
      native.add_membership(native_homeroom, source: 1, state: 0)
    end

    def set_inactive_memberships
      enrollments.this_year.each do |enr|
        if classroom = enr.liberty_classroom
          # native.classroom_memberships.create(classroom: classroom, source: 1, state: 1)
          native.add_membership(classroom, source: 1, state: 1)
        end
      end
    end

    def reset_native_classrooms
      purge_imported_memberships
      set_inactive_memberships
      set_native_homeroom
    end

    def native_homeroom
      @native_homeroom ||= student.enrollments.current.try(:liberty_classroom)
    end

  end

end
