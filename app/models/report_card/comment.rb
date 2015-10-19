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
  belongs_to :comment_group
  has_and_belongs_to_many :report_cards
end
