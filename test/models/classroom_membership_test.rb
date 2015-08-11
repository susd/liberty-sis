# == Schema Information
#
# Table name: classroom_memberships
#
#  id           :integer          not null, primary key
#  student_id   :integer
#  classroom_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class ClassroomMembershipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
