require "test_helper"

class ReportCards::Components::FooterTest < PdfTestCase

  def setup
    @data = ReportCard::PdfData.new(report_cards(:sylvias_card))
    @doc  = ReportCards::Layouts::DefaultLayout.new(@data)
    @foot = ReportCards::Components::Footer.new(@doc, @data)
  end

  test "Rendering footer" do
    @foot.render

    rendered = @doc.render
    inspected = analyze_text(rendered)

    assert_includes inspected.strings, "Ashley Doe"

    output_pdf "footer", rendered
  end
end
