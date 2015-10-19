# == Schema Information
#
# Table name: report_card_grading_periods
#
#  id         :integer          not null, primary key
#  starts_on  :date
#  ends_on    :date
#  position   :integer          default(0), not null
#  year       :integer          default(2015), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class ReportCard::GradingPeriodTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
