# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  name       :text
#  principal  :text
#  abbr       :text
#  code       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Site < ActiveRecord::Base
  has_and_belongs_to_many :employees
  has_many :teachers, foreign_key: :primary_site_id
  has_many :classrooms
  has_many :students

  def self.with_classrooms
    where(id: Classroom.distinct(:site_id).select(:site_id))
  end
end
