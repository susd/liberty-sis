# == Schema Information
#
# Table name: enrollments
#
#  id             :integer          not null, primary key
#  student_id     :integer
#  site_id        :integer
#  classroom_id   :integer
#  grade_id       :integer
#  year           :integer          default(2015)
#  state          :integer          default(0), not null
#  starts_on      :date
#  ends_on        :date
#  import_details :jsonb            not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class EnrollmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
