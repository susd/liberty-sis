class ReportCard::ClassroomGenerator
  PATH = 'tmp/data/pdfs/classrooms'

  def initialize(classroom)
    @classroom = classroom
  end

  def perform!
    prep_destination

    @classroom.students.each do |student|

      gsp = ReportCard::StudentGenerator.new(student)

      if proceed_with_generation?(gsp)
        gsp.perform!
      end

    end
  end

  private

  def prep_destination
    unless File.exists? File.expand_path(PATH, Rails.root)
      FileUtils.mkpath File.expand_path(PATH, Rails.root)
    end
  end

  def proceed_with_generation?(gsp)
    gsp.card && !File.exists?( gsp.destination )
  end
end
