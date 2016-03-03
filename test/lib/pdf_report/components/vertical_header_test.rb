require "test_helper"

class PdfReport::Components::VerticalHeaderTest < PdfTestCase
  def setup
    @doc = PdfReport::Document.new
    @rect = PdfReport::Geometry::Rect.new({
      width: 256,
      height: 112,
      y: 682,
      x: 110
      })
    @header = PdfReport::Components::VerticalHeader.new(@doc, @rect)
  end

  test "Render" do
    items = Array.new(4){ rand_string }

    @header.draw_outer_border
    @header.write_headings(items)

    output_pdf "pdr_vert_header", @doc.render
  end

  private

  def rand_string
    "Aenean lacinia bibendum nulla sed consectetur."[0..rand(6..32)]
  end
end
