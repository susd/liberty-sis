module TypingClub
  class StudentExporter

    def self.header
      ['First Name', 'Last Name', 'Student ID', 'Email', 'Username', 'Password', 'TypingClub ID', 'Grade', 'Action']
    end

    attr_reader :student, :persona

    def initialize(student)
      @student = student
      @persona = student.personas.find_by(handler: 'typing_club')
    end

    def export
      attrs.values
    end

    def attrs
      {
        first: student.first_name,
        last: student.last_name,
        student_id: persona.service_data['student_id'],
        email: student.persona_email,
        username: persona.username,
        password: persona.password,
        club_id: persona.service_id,
        grade: grade,
        action: 'add/update'
      }
    end

    def grade
      student.grade.simple == 0 ? 'K' : student.grade.simple
    end
  end
end
