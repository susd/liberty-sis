# == Schema Information
#
# Table name: roles
#
#  id          :integer          not null, primary key
#  name        :text
#  permissions :jsonb            default({}), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Role < ActiveRecord::Base
  has_and_belongs_to_many :users
end
