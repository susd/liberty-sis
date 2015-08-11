# == Schema Information
#
# Table name: grades
#
#  id         :integer          not null, primary key
#  name       :text
#  position   :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  legacy_id  :integer          default(0), not null
#

class Grade < ActiveRecord::Base
  has_many :students

  def simple
    position ? position.floor : 0
  end
end
