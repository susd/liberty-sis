class ReportCard::Form < ActiveRecord::Base
  has_many :comment_groups
  has_many :comments, through: :comment_groups
  has_many :subjects
end
