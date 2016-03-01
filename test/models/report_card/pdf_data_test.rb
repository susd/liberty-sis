require "test_helper"

class ReportCard::PdfDataTest < ActiveSupport::TestCase

  test "Build subject array, no effort" do
    subj = report_card_subjects(:one)
    card = card_with_subject(subj)

    data = ReportCard::PdfData.new(card)

    arr = data.subject_array(report_card_subjects(:one), 12)

    assert_equal ["Subject name", "", "✓", "", "", "", "✓", "", "", "", "✓", "", ""], arr
  end

  test "Build subject array, with effort" do
    subj = report_card_subjects(:one)
    subj.show_effort = true

    card = card_with_subject(subj)

    data = ReportCard::PdfData.new(card)
    arr = data.subject_array(subj, 12)

    assert_equal ["Subject name", "", "✓", "", "O", "", "✓", "", "O", "", "✓", "", "O"], arr
  end

  test "Bold major subject title" do
    subj = report_card_subjects(:one)
    subj.major = true

    card = card_with_subject(subj)

    data = ReportCard::PdfData.new(card)
    arr = data.subject_array(subj, 12)

    assert_equal( [
      {
        content: "SUBJECT NAME",
        font: PdfReportCard::DEFAULT_BOLD_FONT
      },
      "", "✓", "", "", "", "✓", "", "", "", "✓", "", ""
    ], arr)
  end

  test "Adjusting for non-English home lang" do
    student = students(:sylvia)
    student.home_lang = languages(:es)

    card = student.report_cards.new
    data = ReportCard::PdfData.new(card)

    assert_equal languages(:es), data.home_lang
    assert data.render_translated?
  end

  test "Pass-through title" do
    card = report_cards(:sylvias_card)
    data = ReportCard::PdfData.new(card)

    assert_equal "Primary Progress Report Card", data.title
  end

  private

  def card_with_subject(subj)
    ReportCard.new(
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
  end


end
