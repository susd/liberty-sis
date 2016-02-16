require 'test_helper'

class PdfReportCard::Components::BoxRowTest < ActiveSupport::TestCase

  def setup
    @margin = 24.0
    @doc = Prawn::Document.new(page_size: 'LETTER', margin: @margin)
    @doc.stroke_axis

    rect = PdfReportCard::Geometry::Rect.new(width: 100, height: 300, x: 0, y: 744)

    @row = PdfReportCard::Components::BoxRow.new(rect, @doc, start_y: 744)
    @path = Rails.root.join('test', 'pdf_output')
  end

  test "Drawing box row" do
    @row.render
    rendered = @doc.render

    inspected = PDF::Inspector::Graphics::Rectangle.analyze(rendered)

    assert_equal 3, inspected.rectangles.size
    assert_equal [124.0, 468.0], inspected.rectangles[1][:point]

    File.open(@path.join('box_row_draw.pdf'), 'wb') do |f|
      f.puts rendered
    end
  end
end
