module Aeries

  class StudentImporter

    attr_reader :student

    # def self.import_by_classroom(aeries_school_code, aeries_teacher_number)
    #   students = Aeries::Student.active.where(sc: aeries_school_code, cu: aeries_teacher_number)
    #   students.each do |s|
    #     native_student = new(s).import!
    #     native_student.classrooms <<
    #   end
    # end

    def initialize(aeries_student)
      @student = aeries_student
    end

    def import!(additional_attrs = {})
      attrs = stu.to_student.merge(additional_attrs)
      if liberty_student = ::Student.find_by("import_details -> 'import_id' = ?", student.attributes['id'].to_s)
        student.update(attrs)
      else
        liberty_student = ::Student.create(attrs)
      end
      liberty_student
    end

  end

end
