module Scholastic
  class TeacherExporter
    REGEX = /(\s|-|\'|\")/
    attr_reader :teacher, :site

    def self.header
      %w{DISTRICT_USER_ID SPS_ID PREFIX FIRST_NAME LAST_NAME TITLE SUFFIX EMAIL USER_NAME PASSWORD SCHOOL_NAME CLASS_NAME}
    end

    def initialize(teacher, site = nil)
      @teacher = teacher
      @site = site || teacher.sites.first
    end

    def export
      attrs.values
    end

    def attrs
      {
        district_id: teacher.import_details['import_id'],
        sps_id: sps_id,
        prefix: prefix,
        first: teacher.first_name,
        last: last_name,
        title: 'Teacher',
        suffix: '',
        email: teacher.email,
        user: teacher.persona_username,
        password: schol_password,
        school_name: site.name,
        class_name: class_name
      }
    end

    def last_name
      teacher.last_name.gsub(REGEX, '')
    end

    def sps_id
      '' # => not sure what this is yet
    end

    # guess prefix based on gender
    def prefix
      teacher.sex == "M" ? 'Mr' : 'Ms'
    end

    def class_name
      teacher.persona_username
    end

    def schol_password
      pass = (teacher.last_name[0..4].reverse + site.name.downcase[0..4]).gsub(REGEX, '')
      pass << '001'
      pass
    end
  end
end
