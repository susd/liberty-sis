class PdfSweeper
  def self.path
    Rails.configuration.pdf_path
  end

  def self.keep_set
    set = Set.new ReportCard.pluck(:pdf_path)
    set += Set.new Classroom.fresh_paths
    set
  end

  def self.sweep_set
    Set.new(Dir[path.join('**', '*.pdf')]) - keep_set
  end

  def self.perform!
    sweep_set.each{|f| File.delete(f) if File.exists?(f) }
  end
end
