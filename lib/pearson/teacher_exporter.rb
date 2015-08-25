module Pearson
  class TeacherExporter
    REGEX = /(\s|-|\'|\")/

    attr_reader :teacher

    def self.header
      [
        "username(required)",
        "password(required)",
        "gender(optional)",
        "first name(required)",
        "middle name(optional)",
        "last name(required)",
        "email(required)"
      ]
    end

    def initialize(teacher)
      @teacher = teacher
    end

    def export
      attrs.values
    end

    def attrs
      check_email
      {
        username: teacher.email,
        password: pearson_password,
        gender: teacher.sex,
        first: teacher.first_name,
        middle: nil,
        last: teacher.last_name,
        email: teacher.email
      }
    end

    private

    def check_email
      teacher.email ||= teacher.guess_email
    end

    def pearson_password
      pass = (teacher.last_name[0..6].reverse + site.name.downcase[0..6]).gsub(REGEX, '')
      pass << '001'
      pass
    end

    def site
      teacher.sites.first
    end

  end
end
