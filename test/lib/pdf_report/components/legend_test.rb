require "test_helper"

class PdfReport::Components::LegendTest < PdfTestCase

  test "Drawing border" do
    doc = PdfReport::Document.new
    legend = legend_class.new(doc, rect)

    legend.draw_outer_border

    output_pdf("legend_border", doc.render)
  end

  test "Writing title" do
    doc = PdfReport::Document.new
    legend = legend_class.new(doc, rect)

    legend.draw_outer_border
    legend.write_title("My Legend Title")

    output_pdf("legend_title", doc.render)
  end

  test "Writing two-line title" do
    doc = PdfReport::Document.new
    legend = legend_class.new(doc, rect, title: {lines: 2})

    legend.draw_outer_border
    legend.write_title("My Long\nTwo-line Title")

    output_pdf("legend_title2", doc.render)
  end

  test "Writing list" do
    doc = PdfReport::Document.new
    legend = legend_class.new(doc, rect)

    legend.draw_outer_border
    legend.write_list(%w{✓item1 ✓item2 ✓item3})

    output_pdf("legend_list", doc.render)
  end

  private

  def legend_class
    PdfReport::Components::Legend
  end

  def rect
    PdfReport::Geometry::Rect.new(width: 110, height: 130, y: 700)
  end
end
