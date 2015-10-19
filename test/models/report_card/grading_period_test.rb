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
  test "finding school year" do
    Timecop.travel(Date.new(2015, 8, 12)) do
      assert_equal 2015, ReportCard::GradingPeriod.school_year
    end
    Timecop.travel(Date.new(2016, 2, 28)) do
      assert_equal 2015, ReportCard::GradingPeriod.school_year
    end
    Timecop.travel(Date.new(2016, 7, 15)) do
      assert_equal 2016, ReportCard::GradingPeriod.school_year
    end
  end
end
