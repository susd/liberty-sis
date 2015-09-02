module TypingClub
  class TeacherExporter

    def self.header
      ['instructor-id', 'school-id', 'first name', 'last name', 'email', 'phone', 'password', 'action']
    end

    attr_reader :teacher, :persona

    def initialize(teacher)
      @teacher = teacher
      @persona = teacher.personas.find_by(handler: 'typing_club')
    end

    def export
      attrs.values
    end

    def attrs
      {
        instruct_id: persona.service_id,
        school_id: school_id,
        first: teacher.first_name,
        last: teacher.last_name,
        email: teacher.email,
        phone: nil,
        password: persona.password,
        action: 'update'
      }
    end

    def school_id
      @codes ||= Setting.find_by(name: "typing_club_school_ids").data
      @codes[teacher.primary_site.abbr]
    end

  end
end
