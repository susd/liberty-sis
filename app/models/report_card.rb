# == Schema Information
#
# Table name: report_cards
#
#  id                  :integer          not null, primary key
#  student_id          :integer
#  report_card_form_id :integer
#  data                :jsonb            not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  import_details      :jsonb            not null
#  year                :integer          default(2015), not null
#  employee_id         :integer
#  pdf_path            :text
#  legacy_id           :integer
#

class ReportCard < ActiveRecord::Base
  belongs_to :student
  belongs_to :employee
  belongs_to :form, class_name: 'ReportCard::Form', foreign_key: 'report_card_form_id'

  has_many :sync_events, as: :syncable, dependent: :nullify
  has_many :comment_groups, through: :form
  has_and_belongs_to_many :report_card_comments, join_table: 'comments_report_cards'

  include ReportCard::Pdf

  validates_presence_of :report_card_form_id

  before_update :update_attendance

  def self.this_period
    where("created_at > ?", Period.current.starts_on)
  end

  def editible?
    self.year == SchoolYear.this_year
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

  def update_attendance
    if editible?
      store_attendance(self.student.attendance_by_period)
    end
  end

  def store_attendance(student_attendance_by_period)
    self.data['attendance'] = student_attendance_by_period
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

  def student_id_partition
    ("%09d" % student.import_details['import_id']).scan(/\d{3}/)
  end

  def set_pdf_path
    self.pdf_path = cache_path
  end
end
