require 'prawn'

# require File.expand_path('../pdf_report_card/geometry.rb', __FILE__)
# require File.expand_path('../pdf_report_card/components.rb', __FILE__)
# require File.expand_path('../pdf_report_card/cards.rb', __FILE__)

module PdfReportCard
  DEFAULT_FONT        = File.expand_path('../pdf_report_card/fonts/SourceSansPro-Regular.ttf', __FILE__)
  DEFAULT_BOLD_FONT   = File.expand_path('../pdf_report_card/fonts/SourceSansPro-Bold.ttf', __FILE__)
  DEFAULT_ITALIC_FONT = File.expand_path('../pdf_report_card/fonts/SourceSansPro-Italic.ttf', __FILE__)
  DEFAULT_SIZE      = 8
  
  DEFAULT_FONT_COLOR  = "00" * 3
  DEFAULT_FILL_COLOR  = "EE" * 3
  
  BORDER_WEIGHTS = {
    normal: 0.25,
    heavy: 1
  }
end