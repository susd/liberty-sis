require "test_helper"

class PdfReportCard::Layouts::BaseTest < PdfTestCase

  def setup

    @margin = 24.0
    @doc = Prawn::Document.new(page_size: 'LETTER', margin: @margin)
    @doc.stroke_axis

    @path = Rails.root.join('test', 'pdf_output')

    @layout = PdfReportCard::Layouts::Base.new
  end

  test "Rendering student details" do
    @layout.render_details("John Doe", "Hogwarts", 2007)
    rendered = @layout.render
    inspected = analyze_text(rendered)

    assert_includes inspected.strings, "John Doe"
    assert_includes inspected.strings, "Hogwarts"
    assert_includes inspected.strings, "2007 / 2008"

    output_pdf("base_details", rendered)
  end

  test "Rendering footer details" do
    @layout.render_footer
    rendered = @layout.render
    inspected = analyze_text(rendered)

    assert_includes inspected.strings, "Administrator"

    output_pdf("base_footer", rendered)
  end

  test "Rendering title/address" do
    @layout.render_title_address
    rendered = @layout.render
    inspected = analyze_text(rendered)

    assert_includes inspected.strings, "Progress Report Card"

    output_pdf("base_address", rendered)
  end

  test "Render legend header in English" do
    @layout.render_header
    rendered = @layout.render
    inspected = analyze_text(rendered)

    assert_includes inspected.strings, "Requires Additional Support"

    output_pdf("base_header", rendered)
  end

  test "Renders legend / header en Espanol" do
    @layout.render_spanish_header
    rendered = @layout.render
    inspected = analyze_text(rendered)

    assert_includes inspected.strings, "Requiere Ayuda Adicional"

    output_pdf("base_es_header", rendered)
  end

end
