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
      if ever_enrolled_this_year?
        SyncEvent.wrap(label: 'aeries:student') do |event|
          create_or_update_student
          import_related
          set_classrooms
          event.syncable = native
        end

        return native
      else
        if exists?
          # A student from previous years snuck in,
          # leave all their stuff but remove from classrooms
          native.classroom_memberships.destroy_all
        end

        return false
      end
    end

    def import_if_fresh!
      if fresh?
        import!
      end

      native
    end

    def create_or_update_student
      attrs = student.to_student

      if exists?
        native.update(attrs)
      else
        @native = ::Student.create(attrs)
      end
    end

    def import_related
      import_enrollments
      import_attendance
      import_contacts
    end

    def set_classrooms
      purge_imported_memberships
      set_inactive_memberships
      set_native_homeroom
    end

    def import_enrollments
      enrollments.each do |enr|
        Aeries::EnrollmentImporter.new(enr).import!
      end
      # set all enrollments inactive
      # set current enrollment active
    end

    def import_attendance
      Aeries::AttendanceImporter.new(student).import!
    end

    def import_contacts
      Aeries::HomeContactImporter.new(student).import!
      Aeries::StudentContactsImporter.for_student(native)
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
      if current_native_classroom
        native.homeroom = current_native_classroom
        native.add_membership(current_native_classroom, source: 1, state: 0)
      elsif last_native_classroom
        native.homeroom = last_native_classroom
        native.add_membership(last_native_classroom, source: 1, state: 1)
      else
        native.homeroom = nil
      end
    end

    def set_inactive_memberships
      enrollments.real.this_year.each do |enr|
        if classroom = enr.liberty_classroom
          # native.classroom_memberships.create(classroom: classroom, source: 1, state: 1)
          native.add_membership(classroom, source: 1, state: 1)
        end
      end
    end

    def current_native_classroom
      @current_native_classroom ||= enrollments.current.try(:liberty_classroom)
    end

    def last_native_classroom
      @last_native_classroom ||= enrollments.real.last.try(:liberty_classroom)
    end

    def ever_enrolled_this_year?
      enrollments.real.this_year.any?
    end

  end

end
