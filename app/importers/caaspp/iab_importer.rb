module Caaspp
  class IabImporter

    attr_reader :data

    def initialize(data)
      @data = data.to_hash
    end

    def import
      if student_present?
        create_or_update_assessment
      else
        false
      end
    end

    def student
      @student ||= Student.find_by(ssid: data['StudentIdentifier'])
    end

    def student_present?
      student.present?
    end

    def create_or_update_assessment
      if exists?
        existing.update(assessment_attrs)
      else
        student.assessments.create(assessment_attrs)
      end
    end

    def exists?
      existing.present?
    end

    def existing
      @existing ||= student.assessments.find_by(name: assessment_attrs[:name], taken_on: assessment_attrs[:taken_on])
    end

    def assessment_attrs
      {
        student: student,
        name: data['AssessmentGuid'],
        taken_on: parsed_date,
        data: data.dup.keep_if{|k,v| filtered_columns.exclude? k }
      }
    end

    def parsed_date
      d = data['AssessmentAdministrationFinishDate']
      Date.new(d[0..3].to_i, d[4..5].to_i, d[6..7].to_i)
    end

    def filtered_columns
      %w{AssessmentGuid NameOfInstitution StudentIdentifier FirstName LastOrSurname}
    end

  end
end
