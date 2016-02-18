module ReportCard::ClassroomMethods
  extend ActiveSupport::Concern

  included do
    has_many :report_cards, through: :active_students
  end

  class_methods do
    def fresh_paths
      fields = Classroom.includes(students: :report_cards).pluck('classrooms.id', 'report_cards.updated_at')
      paths = fields.map{|id, stamp| "#{combined_pdf_dir}/#{id}-#{stamp}.pdf"}
    end

    def combined_pdf_dir
      # File.expand_path('public/pdfs/classrooms', Rails.root)
      Rails.configuration.pdf_path.join('classrooms')
    end
  end

  def latest_cards
    @cards ||= active_students.order("students.last_name").map(&:latest_report_card).compact
  end

  def current_cards
    @current_cards ||= report_cards.includes(:student).where(year: SchoolYear.this_year).order("students.last_name")
  end

  def latest_card_date
    ReportCard.where(student_id: active_students).maximum(:updated_at)
  end

  def combined_pdf_name
    "#{id}-#{latest_card_date.to_i}.pdf"
  end

  def combined_pdf_dir
    # File.expand_path('public/pdfs/classrooms', Rails.root)
    # Rails.configuration.pdf_path.join('classrooms')
    self.class.combined_pdf_dir
  end

  def combined_pdf_path
    # "#{combined_pdf_dir}/#{combined_pdf_name}"
    combined_pdf_dir.join(combined_pdf_name)
  end

  def combined_pdf_rel_dir
    # "/pdfs/classrooms"
    combined_pdf_dir.relative_path_from(Rails.root)
  end

  def combined_pdf_rel_path
    # "#{combined_pdf_rel_dir}/#{combined_pdf_name}"
    combined_pdf_rel_dir.join(combined_pdf_name)
  end

  def pdf_generated?
    File.exists? combined_pdf_path
  end
end
