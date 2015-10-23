require 'combine_pdf'

class ReportCard::ClassroomCombiner
  def initialize(classroom)
    @classroom = classroom
  end

  def pdf_paths
    @paths ||= @classroom.current_cards.map(&:cache_path)
  end

  def perform!
    return false unless pdf_paths.any?

    ReportCard::ClassroomGenerator.new(@classroom).perform!

    combined = CombinePDF.new
    pdf_paths.each do |path|
      begin
        com = CombinePDF.new(path)
      rescue RuntimeError => e
        Rails.logger.warn "PDF at #{path} appears to be broken: #{e}"
        next
      end
      combined << CombinePDF.new(path)
    end

    combined.save(@classroom.combined_pdf_path)
  end

end
