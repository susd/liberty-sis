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
      import_classroom
      import_teacher
      import_students
    end

    private

    def import_classroom
      if @classroom = Classroom.find_by(classroom_query, {code: @school_code.to_s, tn: @teacher_num.to_s})
        @classroom.update(name: "#{aeries_teacher.name}'s Class")
      else
        @classroom = Classroom.create(
          import_details: {source: "aeries", import_class: 'Aeries::ClassroomImporter', import_school_code: @school_code, import_teacher_num: @teacher_num},
          site: @site,
          name: "#{aeries_teacher.name}'s Class"
        )
      end
      @classroom
    end

    def import_teacher
      teacher = TeacherImporter.new(aeries_teacher).create_or_update_teacher
      teacher.add_classroom @classroom
      if teacher.primary_classroom.nil?
        teacher.primary_classroom = @classroom
      end
      teacher.sites << @site
      teacher.save
    end

    def import_students
      aeries_students.each do |stu|
        if student = ::Student.find_by("import_details -> 'import_id' = ?", stu.attributes['id'].to_s)
          attrs = stu.to_student.merge(homeroom: @classroom)
          student.update(attrs)
        else
          student = ::Student.new(stu.to_student)
          student.add_classroom @classroom
          student.homeroom = @classroom
          # student.site = @site # already loaded
          student.save
        end
      end
    end

    def classroom_query
      q = "import_details -> 'import_school_code' = :code"
      q << " AND import_details -> 'import_teacher_num' = :tn"
      q
    end

    # /ClassroomImporter
  end

end
