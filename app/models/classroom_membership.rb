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

class ClassroomMembership < ActiveRecord::Base
  belongs_to :student
  belongs_to :classroom
end
