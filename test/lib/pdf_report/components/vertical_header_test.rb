require "test_helper"

class PdfReport::Components::VerticalHeaderTest < PdfTestCase
  def setup
    @doc = PdfReport::Document.new
    @rect = PdfReport::Geometry::Rect.new({
      width: ((@doc.canvas_width * 0.65) - 110),
      height: 112,
      y: 682,
      x: 110
      })
    # @header = 
  end
end
