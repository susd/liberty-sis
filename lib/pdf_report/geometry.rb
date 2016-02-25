module PdfReport
  module Geometry
    def page_margin
      24
    end

    def gutter
      page_margin / 2
    end

    def canvas_width
      (8.5 * 72) - (2 * page_margin)
    end

    def canvas_height
      (11 * 72) - (2 * page_margin)
    end

  end
end
