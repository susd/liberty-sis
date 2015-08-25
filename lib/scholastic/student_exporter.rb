module Scholastic
  class StudentExporter
    attr_reader :student, :persona

    def self.header
      %w{SIS_ID FIRST_NAME MIDDLE_NAME LAST_NAME GRADE USER_NAME PASSWORD SCHOOL_NAME CLASS_NAME}
    end

    def initialize(student)
      @student = student
      @persona = student.personas.find_by(handler: 'scholastic')
    end

    def export
      attrs.values
    end

    def attrs
      {
        sis_id: persona.service_id,
        first: student.first_name,
        middle: student.middle_name,
        last: student.last_name,
        grade: grade,
        username: persona.username,
        password: persona.password,
        school: student.site.name,
        class: class_name
      }
    end

    def class_name
      student.homeroom.teachers.first.persona_username
    end

    def is_male
      student.sex == 'M' ? 'Y' : 'N'
    end

    def is_female
      student.sex == 'F' ? 'Y' : 'N'
    end

    def grade
      student.grade.simple == 0 ? 'K' : student.grade.simple
    end

  end
end
