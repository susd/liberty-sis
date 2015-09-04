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
        middle:     student.middle_name[0],
        gender:     student.sex,
        grade:      grade,
        disability: nil,
        lunch:      nil,
        eld:        nil,
        migrant:    nil,
        race:       nil,
        student_id: persona.service_id,
        username:   persona.username,
        password:   persona.password,
        redemption: nil
      }
    end

    def grade
      student.grade.simple.to_s
    end

    # TODO: allow teachers to input redemption code for export here
    # currently this the *Master Code* which does not work
    #
    # def redemp_code
    #   # setting by grade
    #   Setting.find_by(name: "mcg_codes").data[grade]
    # end
  end

end