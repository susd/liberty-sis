require "test_helper"

class ReportCard::PdfDataTest < ActiveSupport::TestCase

  test "Unknown name" do
    data = ReportCard::PdfData.new(ReportCard.new)

    assert_equal "Name Unknown", data.student_name
  end

  test "Encoded name" do
    card = ReportCard.new(:data => {"student_name" => "Encoded Name"})
    data = ReportCard::PdfData.new(card)

    assert_equal "Encoded Name", data.student_name
  end

  test "Name from student" do
    card = students(:cindy).report_cards.new
    data = ReportCard::PdfData.new(card)

    assert_equal students(:cindy).name, data.student_name
  end

  test "Implicit school year" do
    Timecop.travel(Date.new(2016,2,1)) do
      data = ReportCard::PdfData.new(ReportCard.new)
      assert_equal 2015, data.school_year
    end
  end

  test "Explicit school year" do
    card = ReportCard.new(:data => {:school_year => '2015'})
    data = ReportCard::PdfData.new(card)

    assert_equal 2015, data.school_year
  end

  test "Build subject array, no effort" do
    card = ReportCard.new(
            :form => report_card_forms(:primary),
            :data => {
              :subjects => {
                report_card_subjects(:one).id => {
                  "periods" => {
                    "1"=>{"score"=>1},
                    "2"=>{"score"=>1},
                    "3"=>{"score"=>1}
                  }
                }
              }
            }
            )

    data = ReportCard::PdfData.new(card)

    arr = data.subject_array(report_card_subjects(:one), 12)

    assert_equal ["Subject name", "", "✓", "", "", "", "✓", "", "", "", "✓", "", ""], arr
  end

  test "Build subject array, with effort" do
    subj = report_card_subjects(:one)
    subj.show_effort = true

    card = ReportCard.new(
            :form => report_card_forms(:primary),
            :data => {
              :subjects => {
                subj.id => {
                  "periods" => {
                    "1"=>{"score"=>1, "effort" => "O"},
                    "2"=>{"score"=>1, "effort" => "O"},
                    "3"=>{"score"=>1, "effort" => "O"}
                  }
                }
              }
            }
            )

    data = ReportCard::PdfData.new(card)
    arr = data.subject_array(subj, 12)

    assert_equal ["Subject name", "", "✓", "", "O", "", "✓", "", "O", "", "✓", "", "O"], arr
  end


end
