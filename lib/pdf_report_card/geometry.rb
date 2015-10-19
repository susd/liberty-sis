# require File.expand_path('../geometry/rect.rb', __FILE__)

module PdfReportCard
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
    
    def main_width
      canvas_width * 0.65
    end
    
    def side_width
      canvas_width * 0.35 - gutter
    end
    
    def main_rect
      @main_rect ||= Rect.new(width: main_width, height: 610, x: 0, y: 700)
    end
    
    def title_addr_rect
      @title_rect ||= Rect.new(width: side_width, height: 80, x: main_rect.w + gutter, y: main_rect.y)
    end
    
    def side_rect
      @side_rect ||= Rect.new(width: side_width, height: (main_rect.h - title_addr_rect.h), x: title_addr_rect.x, y: main_rect.y - title_addr_rect.h)
    end
    
    def legend_rect
      @legend_rect ||= Rect.new(width: 110, height: 130, y: main_rect.y)
    end

    def period_rect
      @period_rect ||= Rect.new(width: (main_rect.w - legend_rect.w) / 3, height: 18)
    end

    def heading_rect
      @heading_rect ||= Rect.new(width: (main_rect.w - legend_rect.w) / 12, height: legend_rect.h - period_rect.h, y: main_rect.y - period_rect.h)
    end
    
    def footer_rect
      @footer_rect ||= Rect.new(width: canvas_width, height: 144, x: main_rect.x, y: main_rect.bottom - (gutter / 2))
    end
    
    def comments_rect
      @comments_rect ||= Rect.new(width: canvas_width, height: canvas_height, x: main_rect.x, y: main_rect.y)
    end
    
  end
end