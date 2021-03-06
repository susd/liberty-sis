module Aeries

  class ClassroomImporter
    def initialize(aeries_school_code, aeries_teacher_number)
      @school_code  = aeries_school_code
      @teacher_num  = aeries_teacher_number
      @site         = Site.find_by(code: @school_code)
    end

    def aeries_students
      @students ||= Aeries::Student.where(sc: @school_code, cu: @teacher_num)
    end

    def aeries_teacher
      @teacher ||= Aeries::Teacher.active.find_by(tn: @teacher_num, sc: @school_code)
    end

    def import!
      import_teacher
      import_classroom
      import_students(aeries_students)
    end

    def import_recent!(since = nil)
      import_teacher
      import_classroom

      since ||= last_import

      if aeries_students.where("DTS > ?", since).any?
        SyncEvent.wrap(label: "classroom:students", syncable: native) do
          import_students(aeries_students.where("DTS > ?", since))
        end
      end
    end

    def native
      @native ||= ::Classroom.find_by(["import_details @> ?", import_ids.to_json])
    end

    def exists?
      native.present?
    end

    def import_ids
      {import_school_code: @school_code, import_teacher_num: @teacher_num}
    end

    def native_teacher
      @native_teacher ||= import_teacher
    end

    def import_classroom
      event = SyncEvent.create(label: 'classroom')

      if exists?
        native.update(name: "#{aeries_teacher.name}'s Class")
      else
        @native = Classroom.create({
          site: @site,
          name: "#{aeries_teacher.name}'s Class",
          primary_teacher: native_teacher,
          import_details: {
            source: "aeries",
            import_class: 'Aeries::ClassroomImporter'
          }.merge(import_ids)
        })
      end

      event.update(state: 1, syncable: native)
      native
    end

    def import_teacher
      @native_teacher = TeacherImporter.new(aeries_teacher).import_if_fresh!
    end

    def import_students(student_relation)
      student_relation.each do |stu|
        Aeries::StudentImporter.new(stu).import!
      end
    end

    def last_import
      if native.sync_events.any?
        native.sync_events.where(label: "classroom:students").maximum(:created_at)
      else
        aeries_students.minimum("DTS")
      end
    end

    # /ClassroomImporter
  end

end
