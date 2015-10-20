class ReportCard::StudentGenerator
  attr_reader :card

  def initialize(student)
    @student = student
    @card = student.latest_report_card
  end

  def perform!
    if @card.nil?
      false
    else
      save_pdf
    end
  end

  def destination
    card.cache_path
  end

  def renderer
    @renderer ||= "#{card.form.renderer.capitalize}ReportCardPdf".constantize.new(card)
  end

  private

  def save_pdf
    prep_destination

    File.open(destination, 'wb') do |f|
      f.puts renderer.render
    end
  end

  def prep_destination
    FileUtils.mkpath card.cache_dir
  end
end
