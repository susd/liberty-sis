# == Schema Information
#
# Table name: report_cards
#
#  id                  :integer          not null, primary key
#  student_id          :integer
#  report_card_form_id :integer
#  data                :jsonb
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  import_details      :jsonb            default({}), not null
#  year                :integer          default(2015), not null
#  employee_id         :integer
#

class ReportCard < ActiveRecord::Base
  belongs_to :student
  belongs_to :form, class_name: 'ReportCard::Form', foreign_key: 'report_card_form_id'

  has_many :comment_groups, class_name: 'ReportCard::CommentGroup'
  has_and_belongs_to_many :report_card_comments, join_table: 'comments_report_cards'

  validates_presence_of :report_card_form_id

  def self.this_period
    where("created_at > ?", Period.current.starts_on)
  end

  def fetch_data(keys = [])
    keys.inject(self.data){|data, key| data && data[key] }
  end

  def subject_data(period, subject)
    fetch_data(['subjects', subject.id.to_s, 'periods', period.to_s])
  end

  def comment_data(period)
    fetch_data(['comments', period.to_s, 'comment_ids'])
  end

  def attendance_data(period, key)
    fetch_data(['attendance', period.to_s, key.to_s])
  end

  def store_attendance(attedance_by_type)
    self.data['attendance'] ||= {}
    attedance_by_type.each do |key, periods|
      self.data['attendance'][key] = periods
    end
  end

  def attendance_by_type
    hsh = {absences: [], tardies: []}
    (1..3).each do |i|
      hsh[:absences][i] = attendance_data(i, 'absences')
      hsh[:tardies][i]  = attendance_data(i, 'tardies')
    end
    hsh.each{|k,v| v.compact! }
  end

  def has_subject?(period, subject)
    fetch_data(['subjects', subject.id.to_s]).present?
  end

  def has_comments?(period)
    comments = fetch_data(['comments', period.to_s, 'comment_ids'])
    comments && comments.any?
  end

  def cache_path
    "#{cache_dir}/#{cache_name}"
  end

  def cache_name
    "#{student.name.parameterize}-progress_card_#{updated_at.strftime('%Y%m%d-%H%M')}.pdf"
  end

  def cache_dir
    File.expand_path("public/pdfs/students/#{student_id_partition}", Rails.root)
  end

  def cache_rel_dir
    "/pdfs/students/#{student_id_partition}"
  end

  def cache_rel_path
    "#{cache_rel_dir}/#{cache_name}"
  end

  def cache_exists?
    File.exists? cache_path
  end

  private

  def student_id_partition
    ("%09d" % student.aeries_id).scan(/\d{3}/).join("/")
  end
end
