module ReportCard::ClassroomMethods
  extend ActiveSupport::Concern

  def latest_cards
    @cards ||= students.map(&:latest_report_card).compact
  end

  def latest_card_date
    ReportCard.where(student_id: students).maximum(:updated_at)
  end

  def combined_pdf_name
    "#{id}-#{latest_card_date.to_i}.pdf"
  end

  def combined_pdf_dir
    # File.expand_path('public/pdfs/classrooms', Rails.root)
    Rails.configuration.pdf_path.join('classrooms')
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
