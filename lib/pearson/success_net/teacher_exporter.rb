module Pearson
  module SuccessNet

    class TeacherExporter

      def self.header
        [
          "FirstName",
          "LastName",
          "TeacherID",
          "UserName", "Password",
          "PasswordConfirmation",
          "EmailAddress",
          "EmailAddressConfirmation"
        ].join("\t")
      end

      attr_reader :teacher, :persona

      def initialize(teacher)
        @teacher = teacher
        @persona = teacher.personas.find_by(handler: 'successnet')
      end

      def export
        attrs.values
      end

      def attrs
        {
          first: teacher.first_name,
          last: teacher.last_name,
          teacher_id: persona.service_id,
          username: persona.username,
          password: persona.password,
          password_conf: persona.password,
          email: teacher.email,
          email_conf: teacher.email
        }
      end
    end

  end
end
