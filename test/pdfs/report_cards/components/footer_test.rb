require "test_helper"

class ReportCards::Components::FooterTest < PdfTestCase

  def setup
    card    = report_cards(:sylvias_card)
    card.data['services'] = %w{service1 service2 service3}

    @data   = ReportCard::PdfData.new(card)
    @layout = ReportCards::Layouts::DefaultLayout.new(@data)
    @foot   = ReportCards::Components::Footer.new(@layout, @data)
  end

  test "Rendering footer" do
    @foot.render

    rendered = @layout.document.render
    inspected = analyze_text(rendered)

    assert_includes inspected.strings, "Ashley Doe"
    assert_includes inspected.strings, "service1, service2, service3"

    output_pdf "footer", rendered
  end

end
