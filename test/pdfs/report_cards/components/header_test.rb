require "test_helper"

class ReportCards::Components::HeaderTest < PdfTestCase
  def setup
    @data = ReportCard::PdfData.new(report_cards(:sylvias_card))
    @layout  = ReportCards::Layouts::DefaultLayout.new(@data)
    @header = ReportCards::Components::Header.new(@layout, @data)
  end

  test "Rendering header" do
    @header.render

    rendered = @layout.document.render

    output_pdf "header", rendered
  end
end
