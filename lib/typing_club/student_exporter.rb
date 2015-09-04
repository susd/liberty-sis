module TypingClub
  class StudentExporter

    def self.header
      ['student-id', 'class-id', 'school-id', 'first name', 'last name', 'username', 'password', 'email', 'grade', 'action']
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
        student_id: persona.service_data['student_id'],
        class_id:   student.homeroom_id,
        school_id:  school_id,
        first:      student.first_name,
        last:       student.last_name,
        username:   persona.username,
        password:   persona.password,
        email:      student.persona_email,
        grade:      grade,
        action:     'update'
      }
    end

    def grade
      student.grade.simple == 0 ? 'K' : student.grade.simple
    end

    def school_id
      @codes ||= Setting.find_by(name: "typing_club_school_ids").data
      @codes[student.site.abbr]
    end
  end
end
