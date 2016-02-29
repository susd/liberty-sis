# == Schema Information
#
# Table name: classroom_memberships
#
#  id           :integer          not null, primary key
#  student_id   :integer
#  classroom_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  state        :integer          default(0), not null
#  source       :integer          default(0), not null
#

class ClassroomMembership < ActiveRecord::Base
  enum state: {active: 0, inactive: 1}
  enum source: {from_user: 0, imported: 1}

  belongs_to :student
  belongs_to :classroom
end
