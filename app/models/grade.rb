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

  def succ
    case position
    when 0.0..0.5
      Grade.find_by(position: 0.8)
    when 0.8
      Grade.find_by(position: 1.0)
    else
      Grade.find_by(position: self.position + 1)
    end
  end
end
