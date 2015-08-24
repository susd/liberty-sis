module Scholastic
  class TeacherExporter
    attr_reader :teacher

    def self.header
      %w{DISTRICT_USER_ID SPS_ID PREFIX FIRST_NAME LAST_NAME TITLE SUFFIX EMAIL USER_NAME PASSWORD SCHOOL_NAME CLASS_NAME}
    end

    def initialize(teacher)
      @teacher = teacher
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
        last: teacher.last_name,
        title: 'Teacher',
        suffix: ''
      }
    end

    def sps_id
      '' # => not sure what this is yet
    end

    # guess prefix based on gender
    def prefix
      teacher.sex == "M" ? 'Mr' : 'Ms'
    end
  end
end
