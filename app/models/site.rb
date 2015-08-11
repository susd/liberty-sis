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
end
