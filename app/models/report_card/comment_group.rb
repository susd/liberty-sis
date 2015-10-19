class ReportCard::CommentGroup < ActiveRecord::Base
  belongs_to :form
  has_many :comments
end
