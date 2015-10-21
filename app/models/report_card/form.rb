# == Schema Information
#
# Table name: report_card_forms
#
#  id         :integer          not null, primary key
#  name       :string
#  renderer   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ReportCard::Form < ActiveRecord::Base
  has_many :comment_groups, foreign_key: 'report_card_form_id'
  has_many :comments, through: :comment_groups
  has_many :subjects, foreign_key: 'report_card_form_id'
end
