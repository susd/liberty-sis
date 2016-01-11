module Caaspp
  class IabExporter
    def self.header
      # A,I, K, M, AQ, AR, AS, AT
      %w{
        FirstName LastName
        FinishDate
        Result
        Level
        Minimum
        Maximum
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
