module Mcgraw

  class StudentExporter
    attr_reader :student, :persona

    def initialize(student)
      @student = student
      @persona = student.personas.find_by(handler: 'mcgraw')
    end

    def export
      attrs.values
    end

    def attrs
      {
        last:       student.last_name,
        first:      student.first_name,
        middle:     student.middle_name,
        gender:     student.sex,
        grade:      student.grade.simple,
        disability: nil,
        lunch:      nil,
        eld:        nil,
        migrant:    nil,
        race:       nil,
        student_id: persona.service_id,
        username:   persona.username,
        password:   persona.password,
        redemption: redemp_code
      }
    end

    def redemp_code
      # setting by grade
      Setting.find_by(name: "mcg_#{student.grade.simple}_code").data['code']
    end
  end

end
