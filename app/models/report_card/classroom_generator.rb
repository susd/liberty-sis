class ReportCard::ClassroomGenerator
  PATH = 'tmp/data/pdfs/classrooms'

  def initialize(classroom)
    @classroom = classroom
  end

  def perform!
    prep_destination

    @classroom.report_cards.where(year: ReportCard::GradingPeriod.school_year).each do |card|

      gen = ReportCard::CardGenerator.new(card)

      if proceed_with_generation?(gen)
        gen.perform!
      end

    end
  end

  private

  def prep_destination
    unless File.exists? File.expand_path(PATH, Rails.root)
      FileUtils.mkpath File.expand_path(PATH, Rails.root)
    end
  end

  def proceed_with_generation?(gen)
    gen.card && !File.exists?( gen.destination )
  end
end
