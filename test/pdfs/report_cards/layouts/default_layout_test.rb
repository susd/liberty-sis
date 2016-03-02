require "test_helper"

class ReportCards::Layouts::DefaultLayoutTest < PdfTestCase
  def setup
    @card = ReportCard.new(form: report_card_forms(:primary))
    @path = Rails.root.join('test', 'pdf_output')
  end

  test "Renders without error" do
    data = ReportCard::PdfData.new(@card)
    layout = ReportCards::Layouts::DefaultLayout.new(data)

    output_pdf "rp_default_layout", layout.render
  end

  test "English heading items" do
    data = ReportCard::PdfData.new(@card)
    layout = ReportCards::Layouts::DefaultLayout.new(data)

    assert_includes layout.heading_items, "Requires Additional Support"
  end

  test "Spanish heading_items" do
    @card.data['home_lang'] = "Spanish"
    data = ReportCard::PdfData.new(@card)
    layout = ReportCards::Layouts::DefaultLayout.new(data)

    assert_includes layout.translated{ layout.heading_items }, "Requiere Ayuda Adicional"
  end

end
