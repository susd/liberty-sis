require "test_helper"

class ReportCard::DefaultDataTest < ActiveSupport::TestCase

  test "Unknown name" do
    data = ReportCard::DefaultData.new(ReportCard.new)

    assert_equal "Name Unknown", data.student_name
  end

  test "Encoded name" do
    card = ReportCard.new(:data => {"student_name" => "Encoded Name"})
    data = ReportCard::DefaultData.new(card)

    assert_equal "Encoded Name", data.student_name
  end

  test "Name from student" do
    card = students(:cindy).report_cards.new
    data = ReportCard::DefaultData.new(card)

    assert_equal students(:cindy).name, data.student_name
  end

  test "Implicit school year" do
    Timecop.travel(Date.new(2016,2,1)) do
      data = ReportCard::DefaultData.new(ReportCard.new)
      assert_equal 2015, data.school_year
    end
  end

  test "Explicit school year" do
    card = ReportCard.new(:data => {:school_year => '2015'})
    data = ReportCard::DefaultData.new(card)

    assert_equal 2015, data.school_year
  end


end
