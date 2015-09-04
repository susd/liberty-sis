module TypingClub
  class ClassExporter

    def self.header
      ['class-id', 'instructor-id', 'school-id', 'name', 'description', 'grade', 'action']
    end

    attr_reader :classroom, :teacher

    def initialize(classroom)
      @classroom = classroom
      @teacher = classroom.primary_teacher
    end

    def export
      attrs.values
    end

    def attrs
      {
        class_id: classroom.id,
        instructor_id: instructor_id,
        school_id: school_id,
        name: name,
        description: nil,
        grade: nil,
        action: 'update'
      }
    end

    def instructor_id
      teacher.personas.find_by(handler: 'typing_club').service_id
    end

    def school_id
      @codes ||= Setting.find_by(name: "typing_club_school_ids").data
      @codes[teacher.primary_site.abbr]
    end

    def name
      "#{classroom.name} (15-16)"
    end

  end
end
