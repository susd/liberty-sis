require "test_helper"

class ReportCards::Layouts::DefaultLayoutTest < ActiveSupport::TestCase
  def setup
    @card = ReportCard.new(form: report_card_forms(:primary))
    @path = Rails.root.join('test', 'pdf_output')
  end

  test "Renders without error" do
    data = ReportCard::PdfData.new(@card)
    layout = ReportCards::Layouts::DefaultLayout.new(data)

    output_pdf("default_layout", layout.render)
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

  private

  def output_pdf(name, rendered_doc)
    File.open(@path.join("#{name}.pdf"), 'wb') do |f|
      f.puts rendered_doc
    end
  end
end
