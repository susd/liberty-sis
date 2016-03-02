require "test_helper"

class ReportCards::Components::LegendTest < PdfTestCase

  def setup
    card    = report_cards(:sylvias_card)

    @data   = ReportCard::PdfData.new(card)
    @layout = ReportCards::Layouts::DefaultLayout.new(@data)
    @legend = ReportCards::Components::Legend.new(@layout, @data)
  end

  test "Rendering legend" do
    @legend.render

    rendered = @layout.document.render
    inspected = analyze_text(rendered)

    assert_includes inspected.strings, "Effort Grades"
    assert_includes inspected.strings, "S - Satisfactory"

    output_pdf "rp_legend", rendered
  end

  test "Translated legend" do
    card = report_cards(:sylvias_card)
    card.data['home_lang'] = "Spanish"

    data   = ReportCard::PdfData.new(card)
    layout = ReportCards::Layouts::DefaultLayout.new(data)
    legend = ReportCards::Components::Legend.new(layout, data)

    layout.translated do
      legend.render
    end

    rendered  = layout.document.render
    inspected = analyze_text(rendered)

    assert_includes inspected.strings, "Calificacion del Esfuerzo"
    assert_includes inspected.strings, "S - Satisfactorio"

    output_pdf "rp_legend_es", rendered
  end

end
