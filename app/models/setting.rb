# == Schema Information
#
# Table name: settings
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  data       :jsonb            default({}), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Setting < ActiveRecord::Base
  def self.[](name)
    find_by(name: name)
  end
end
