# == Schema Information
#
# Table name: report_cards
#
#  id                            :integer          not null, primary key
#  student_id                    :integer
#  report_card_form_id           :integer
#  data                          :jsonb
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  import_details                :jsonb            default({}), not null
#  report_card_grading_period_id :integer
#

class ReportCard < ActiveRecord::Base
  belongs_to :student
  belongs_to :form, class_name: 'ReportCard::Form', foreign_key: 'report_card_form_id'

  has_and_belongs_to_many :report_card_comments, join_table: 'comments_report_cards'
end
