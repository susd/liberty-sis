# == Schema Information
#
# Table name: languages
#
#  id           :integer          not null, primary key
#  name         :text
#  calpads_name :text
#  calpads_code :integer
#  aeries_code  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Language < ActiveRecord::Base
end
