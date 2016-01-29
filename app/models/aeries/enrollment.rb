module Aeries
  class Enrollment < Base
    self.table_name = 'ENR'
    self.primary_keys = [:id, :yr, :sc, :sn, :ed]

    def self.by_student(aeries_student)
      where(id: aeries_student.attributes['id'])
    end

    def self.active
      where(ld: nil) # => that's lima-delta
    end

    def self.this_year
      where(ed: ReportCard::GradingPeriod.current_year_range)
    end

    def self.current
      active.order(ed: :desc).first
    end

    def id
      attr_names = self.class.primary_keys
      attr_map = attr_names.map do |attr_name|
        if attr_name == 'id'
          attributes['id']
        else
          read_attribute(attr_name)
        end
      end
      ::CompositePrimaryKeys::CompositeKeys.new(attr_map)
    end

    def to_enrollment
      {
        student: liberty_student,
        site: liberty_site,
        classroom: liberty_classroom,
        grade: liberty_grade,
        year: attributes['yr'],
        state: state,
        starts_on: enter_date,
        ends_on: leave_date,
        import_details: {
          source: 'aeries',
          import_class: self.class.to_s
        }.merge(import_ids)
      }
    end

    def student
      @student ||= Aeries::Student.find_by(sc: attributes['sc'], sn: attributes['sn'])
    end

    def enter_date
      read_attribute_before_type_cast('ed').to_date
    end

    def leave_date
      ld && read_attribute_before_type_cast('ld').to_date
    end

    def state
      attributes['ld'].nil? ? 1 : 0
    end

    def liberty_site
      @site ||= ::Site.find_by(code: attributes['sc'])
    end

    def liberty_student
      @student ||= ::Student.find_by(["import_details -> 'import_id' = ?", attributes['id'].to_json])
    end

    def liberty_classroom
      @classroom ||= ::Classroom.find_by([
        "import_details -> 'import_school_code' = :sc AND import_details -> 'import_teacher_num' = :tn",
        {sc: attributes['sc'].to_json, tn: attributes['tn'].to_json}
        ])
    end

    def liberty_grade
      if ['T', 'U'].include? student.attributes['sp']
        Grade.find_by(position: 0.5)
      else
        Grade.where.not(position: 0.5).find_by(legacy_id: attributes['gr'])
      end
    end

    def import_ids
      {
        import_id: attributes['id'],
        import_year: attributes['yr'],
        import_school_code: attributes['sc'],
        import_student_num: attributes['sn'],
        import_enter_date: enter_date
      }
    end

  end
end
