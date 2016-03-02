require "test_helper"

class ReportCards::Components::PageHeaderTest < PdfTestCase
  def setup
    @data = ReportCard::PdfData.new(report_cards(:sylvias_card))
    @layout  = ReportCards::Layouts::DefaultLayout.new(@data)
    @header = ReportCards::Components::PageHeader.new(@layout, @data)
  end

  test "Rendering header" do
    @header.render

    rendered = @layout.document.render

    output_pdf "header", rendered
  end
end
