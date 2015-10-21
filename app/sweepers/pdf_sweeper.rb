class PdfSweeper
  def self.path
    Rails.configuration.pdf_path
  end

  def self.keep_set
    Set.new ReportCard.pluck(:pdf_path)
  end

  def self.sweep_set
    Set.new(Dir[path.join('**', '*.pdf')]) - keep_set
  end

  def self.perform!
    sweep_set.each{|f| File.delete(f) }
  end
end
