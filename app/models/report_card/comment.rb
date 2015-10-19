class ReportCard::Comment < ActiveRecord::Base
  belongs_to :comment_group
  has_and_belongs_to_many :report_cards
end
