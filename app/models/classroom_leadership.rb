# == Schema Information
#
# Table name: classroom_leaderships
#
#  id           :integer          not null, primary key
#  employee_id  :integer
#  classroom_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class ClassroomLeadership < ActiveRecord::Base
  belongs_to :employee
  belongs_to :classroom
end
