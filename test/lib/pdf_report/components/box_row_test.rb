require "test_helper"

class PdfReport::Components::BoxRowTest < PdfTestCase
  def setup
    @doc = PdfReport::Document.new
    @rect = PdfReport::Geometry::Rect.new({
      width: 256,
      height: 112,
      y: 682,
      x: 110
      })

  end

  test "Render" do

    output_pdf "pdr_vert_header", @doc.render
  end

end
