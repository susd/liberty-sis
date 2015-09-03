module TypingClub
  class ClassExporter

    attr_reader :classroom

    def initialize(classroom)
      @classroom = classroom
    end

    def export
      attrs.export
    end

    def attrs
      {
        class_id: classroom.id
      }
    end

  end
end
