require "test_helper"

class PdfReportCard::Components::SectionTest < ActiveSupport::TestCase
  def setup
    @margin = 24.0
    @doc = Prawn::Document.new(page_size: 'LETTER', margin: @margin)
    @doc.stroke_axis

    rect = PdfReportCard::Geometry::Rect.new(width: 100, height: 300, x: 0, y: 744)

    @sec = PdfReportCard::Components::Section.new(@doc, rect)
    @path = Rails.root.join('test', 'pdf_output')
  end

  test "Add table" do
    data = [["Hello"] * 3]
    @sec.add_table(data) do |tbl|
      tbl.cells.border_colors = ["3" * 6, "A" * 6]
    end

    output_pdf("section_add_table", @doc.render)
  end


  private

  def output_pdf(name, rendered_doc)
    File.open(@path.join("#{name}.pdf"), 'wb') do |f|
      f.puts rendered_doc
    end
  end
end
