# == Schema Information
#
# Table name: grading_periods
#
#  id         :integer          not null, primary key
#  start      :date
#  finish     :date
#  position   :integer
#  year       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class GradingPeriodTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
