module Caaspp
  class IabExporter
    def self.header
      # A,I, K, M, AQ, AR, AS, AT
      %w{
        AssessmentGuid NameOfInstitution StudentIdentifier FirstName LastName
        AssessmentAdministrationFinishDate
        AssessmentSubtestResultScoreClaim1Value
        AssessmentClaim1PerformanceLevelIdentifier
        AssessmentSubtestClaim1MinimumValue
        AssessmentSubtestClaim1MaximumValue
      }
    end

    attr_reader :assessment

    def initialize(assessment)
      @assessment = assessment
    end

    def student
      @student ||= assessment.student
    end

    def export
      [
        assessment.name,
        student.site.name,
        student.ssid,
        student.first_name,
        student.last_name,
        assessment.taken_on.to_s,
        assessment.fetch_data(['AssessmentSubtestResultScoreClaim1Value']),
        assessment.fetch_data(['AssessmentClaim1PerformanceLevelIdentifier']),
        assessment.fetch_data(['AssessmentSubtestClaim1MinimumValue']),
        assessment.fetch_data(['AssessmentSubtestClaim1MaximumValue'])
      ]
    end
  end
end
