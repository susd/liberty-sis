module Pearson
  class StudentClassExporter
    attr_reader :student, :persona

    def initialize(student)
      @student = student
      @persona = student.personas.find_by(handler: 'pearson')
    end

    def attrs
      {
        username: persona.username,
        password: persona.password,
        first: student.first_name,
        last: student.last_name,
        teacher: teacher_user,
        classname: classname,
        subscription: subscription
      }
    end

    def classname
      # teacher_user + "class"
    end

    def subscription
      # figure out book by grade, pipe separated
    end
  end
end
