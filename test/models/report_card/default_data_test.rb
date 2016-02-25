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
    card = students(:sylvia).report_cards.new
    data = ReportCard::DefaultData.new(card)

    assert_equal students(:sylvia).name, data.student_name
  end

  test "Implicit school year" do
    Timecop.travel(Date.new(2016,2,1)) do
      data = ReportCard::DefaultData.new(ReportCard.new)
      assert_equal 2015, data.school_year
    end
  end

  test "Explicit school year" do
    card = ReportCard.new(:data => {:school_year => "2015"})
    data = ReportCard::DefaultData.new(card)

    assert_equal 2015, data.school_year
  end

  test "Implicit school name" do
    student = students(:sylvia)
    card = student.report_cards.new
    data = ReportCard::DefaultData.new(card)

    assert_equal student.site.name, data.school_name
  end

  test "Explicit school name" do
    card = ReportCard.new(:data => {:school_name => "Hogwarts"})
    data = ReportCard::DefaultData.new(card)

    assert_equal "Hogwarts", data.school_name
  end

  test "Implicit teacher name" do
    card = students(:sylvia).report_cards.new
    data = ReportCard::DefaultData.new(card)

    assert_equal "Ashley Doe", data.teacher_name
  end

  test "Implicit home language" do
    student = students(:sylvia)
    student.home_lang = languages(:es)
    card = student.report_cards.new
    data = ReportCard::DefaultData.new(card)

    assert_equal languages(:es), home_lang
  end

  test "Setting default data without saving" do
    card = students(:sylvia).report_cards.new({
      :data => {:school_name => "Hogwarts"},
      :form => report_card_forms(:primary)
      })

    ReportCard::DefaultData.set_defaults(card)

    assert card.new_record?
    assert_equal "Hogwarts", card.fetch_data(['school_name'])
    assert_equal students(:sylvia).name, card.fetch_data(['student_name'])
    assert_equal 2015, card.fetch_data(['school_year'])
  end

  test "Saving default data" do
    card = students(:sylvia).report_cards.create!({
      :data => {:school_name => "Hogwarts"},
      :form => report_card_forms(:primary)
      })

    ReportCard::DefaultData.save_defaults(card)

    card.reload

    assert_equal "Hogwarts", card.fetch_data(['school_name'])
    assert_equal students(:sylvia).name, card.fetch_data(['student_name'])
    assert_equal 2015, card.fetch_data(['school_year'])
  end


end
