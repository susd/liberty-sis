class PdfTestCase < ActiveSupport::TestCase

  private

  def analyze_text(rendered_doc)
    PDF::Inspector::Text.analyze(rendered_doc)
  end

  def analyze_rect(rendered_doc)
    PDF::Inspector::Graphics::Rectangle.analyze(rendered_doc)
  end

  def output_pdf(name, rendered_doc)
    path = @path || Rails.root.join('test', 'pdf_output')

    File.open(path.join("#{name}.pdf"), 'wb') do |f|
      f.puts rendered_doc
    end
  end
end
