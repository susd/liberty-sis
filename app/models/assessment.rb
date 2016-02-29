# == Schema Information
#
# Table name: assessments
#
#  id         :integer          not null, primary key
#  student_id :integer
#  name       :string
#  data       :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  taken_on   :date
#

class Assessment < ActiveRecord::Base
  belongs_to :student

  def fetch_data(keys = [])
    keys.inject(self.data){|data, key| data && data[key] }
  end
end
