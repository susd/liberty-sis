require 'test_helper'

module Caaspp
  class IabImporterTest < ActiveSupport::TestCase
    def setup
      data = {
        "AssessmentGuid"=>"SBAC-IAB-FIXED-G3M-OA-MATH-3",
        "NameOfInstitution"=>"Bridgeport Elementary",
        "StudentIdentifier"=>"1234567899",
        "FirstName"=>"Sylvia",
        "AssessmentAdministrationFinishDate" => "20151215",
        "LastOrSurname"=>"McFakerton",
        "AssessmentSubtestResultScoreClaim1Value"=>"2447",
        "AssessmentClaim1PerformanceLevelIdentifier"=>"2",
        "AssessmentSubtestClaim1MinimumValue"=>"2414",
        "AssessmentSubtestClaim1MaximumValue"=>"2480"
      }
      @importer = Caaspp::IabImporter.new(data)
    end

    test "Data with named columns" do
      assert_not_nil @importer.data['AssessmentGuid']
    end

    test "Parses the date" do
      assert_equal Date.new(2015, 12, 15), @importer.parsed_date
    end

    test "finds student" do
      assert_equal students(:sylvia), @importer.student
    end

    test "creates a new assessment" do
      @importer.import
      assert_not_nil students(:sylvia).assessments.find_by(name: 'SBAC-IAB-FIXED-G3M-OA-MATH-3')
    end

  end
end
