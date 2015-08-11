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

class GradingPeriod < ActiveRecord::Base
end
