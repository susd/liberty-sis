module ReportCard::Pdf
  extend ActiveSupport::Concern

  included do
    before_update :set_pdf_path
  end
  
  class_methods do
    def cache_dir
      Rails.configuration.pdf_path
    end
  end

  def cache_path
    "#{cache_dir}/#{cache_name}"
  end

  def cache_name
    "#{student.name.parameterize}-progress_card_#{updated_at.strftime('%Y%m%d-%H%M')}.pdf"
  end

  def cache_dir
    self.class.cache_dir.join('students', *student_id_partition).to_s
  end

  def cache_rel_dir
    self.class.cache_dir.relative_path_from(Rails.root).join('students', *student_id_partition).to_s
  end

  def cache_rel_path
    "#{cache_rel_dir}/#{cache_name}"
  end

  def cache_exists?
    File.exists? cache_path
  end

end
