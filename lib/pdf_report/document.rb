require 'prawn'

module PdfReport
  class Document
    include Prawn::View
    include Geometry

    def initialize
      self.line_width = PdfReport::BORDER_WEIGHTS[:normal]
      set_defaults
    end

    def set_defaults
      font_families.update("SourceSansPro" => {
        :normal => PdfReport::DEFAULT_FONT,
        :bold   => PdfReport::DEFAULT_BOLD_FONT,
        :italic => PdfReport::DEFAULT_ITALIC_FONT
      })
      font 'SourceSansPro'
      font_size PdfReport::DEFAULT_SIZE
    end

    def document
      @document ||= Prawn::Document.new(page_size: 'LETTER', margin: page_margin)
    end

    alias :doc :document

    # method_missing => document (Prawn::View)
  end
end
