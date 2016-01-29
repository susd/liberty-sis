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
  test "creating year" do
    start_dates = [
      Date.new(2015, 8, 12),
      Date.new(2015, 11, 20),
      Date.new(2016, 3, 14)
    ]
    last_date = Date.new(2016, 06, 10)
    ReportCard::GradingPeriod.create_year(start_dates, last_date)

    assert_equal 3, ReportCard::GradingPeriod.where(starts_on: (start_dates.first..last_date)).count

    Timecop.travel(Date.new(2015, 10, 20)) do
      assert_equal 3, ReportCard::GradingPeriod.current_year.count
      assert_equal start_dates[0], ReportCard::GradingPeriod.current_year.first.starts_on
      assert_equal (start_dates[1] - 1.day), ReportCard::GradingPeriod.current_year.first.ends_on
      assert_equal last_date, ReportCard::GradingPeriod.current_year.last.ends_on
    end
  end
end
