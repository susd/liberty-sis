class ReportCard < ActiveRecord::Base
  belongs_to :student
  belongs_to :report_card_form
end
