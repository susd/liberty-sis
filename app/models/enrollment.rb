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

class Enrollment < ActiveRecord::Base
  enum state: {inactive: 0, active: 1}

  belongs_to :student
  belongs_to :site
  belongs_to :classroom
  belongs_to :grade

  def self.active
    where(state: 1)
  end
end
