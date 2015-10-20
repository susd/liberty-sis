# == Schema Information
#
# Table name: attendances
#
#  id             :integer          not null, primary key
#  student_id     :integer
#  date           :date
#  day            :integer          default(0), not null
#  kind           :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  import_details :jsonb            default({}), not null
#

require 'test_helper'

class AttendanceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
