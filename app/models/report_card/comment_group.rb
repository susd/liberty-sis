# == Schema Information
#
# Table name: report_card_comment_groups
#
#  id                  :integer          not null, primary key
#  name                :string
#  report_card_form_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class ReportCard::CommentGroup < ActiveRecord::Base
  belongs_to :form, foreign_key: 'report_card_form_id'
  has_many :comments, foreign_key: 'report_card_comment_group_id'
end
