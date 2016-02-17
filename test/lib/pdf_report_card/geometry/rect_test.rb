require 'test_helper'

class PdfReportCard::Geometry::RectTest < ActiveSupport::TestCase

  def setup
    @margin = 24.0
    @doc = Prawn::Document.new(page_size: 'LETTER', margin: @margin)
    @doc.stroke_axis

    @rect = PdfReportCard::Geometry::Rect.new(width: 10, height: 15, x: 0, y: 744)
    @path = Rails.root.join('test', 'pdf_output')
  end

  test "Drawing a rectangle" do
    @rect.draw(@doc)
    rendered = @doc.render
    inspected = PDF::Inspector::Graphics::Rectangle.analyze(rendered)
    rnd_rect = inspected.rectangles.first

    assert_equal [@margin, (744 + @margin - 15)], rnd_rect[:point]
    assert_equal 10, rnd_rect[:width]
    assert_equal 15, rnd_rect[:height]

    File.open(@path.join('rect_draw.pdf'), 'wb') do |f|
      f.puts rendered
    end
  end

  test "Filling rectangle" do
    @rect.fill(@doc)

    File.open(@path.join('rect_fill.pdf'), 'wb') do |f|
      f.puts @doc.render
    end
  end

  test "Finding the bottom" do
    assert_equal 729, @rect.bottom
  end

  test "Converting to bounding box" do
    assert_equal [[0, 744], {width: 10, height: 15}], @rect.to_bb
  end

  test "Padding" do
    assert_equal 6, @rect.padded_w(2)
    assert_equal 5, @rect.padded_h(5)
  end
end