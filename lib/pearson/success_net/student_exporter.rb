module Pearson
  module SuccessNet

    class StudentExporter

      def self.header
        [
          "School ID",
          "FirstName",
          "MiddleInitial",
          "LastName",
          "StudentID",
          "Grade",
          "SuccessNetLanguage",
          "UserName", "Password",
          "PasswordConfirmation",
          "Gender",
          "EnglishLanguageProficiency",
          "Ethnicity",
          "MealProgram",
          "SpecialCondition",
          "MigrantStatus",
          "SpecialServices"
        ].join("\t")
      end

      attr_reader :student, :site, :codes, :persona

      def initialize(student)
        @student = student
        @site = student.site
        @codes = Setting.find_by(name: "pearson_sn_school_codes").data
        @persona = student.personas.find_by(handler: 'successnet')
      end

      def export
        attrs.values
      end

      def attrs
        {
          school_id: codes[site.abbr],
          first: student.first_name,
          middle: student.middle_name,
          last: student.last_name,
          student_id: persona.service_id,
          grade: grade,
          lang: 'ENG',
          username: persona.username,
          password: persona.password,
          password_conf: persona.password,
          gender: nil,
          eng_lang: nil,
          ethnicity: nil,
          meal: nil,
          special: nil
        }
      end

      def grade
        student.grade.simple == 0 ? 'K' : ("%02d" % student.grade.simple)
      end
    end

  end
end
