# == Schema Information
#
# Table name: report_card_comments
#
#  id                           :integer          not null, primary key
#  english                      :text
#  spanish                      :text
#  report_card_comment_group_id :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#

class ReportCard::Comment < ActiveRecord::Base
  belongs_to :comment_group, foreign_key: 'report_card_comment_group_id'
  has_and_belongs_to_many :report_cards, join_table: 'comments_report_cards'
end
