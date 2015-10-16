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

  def self.teacher
    find_by(name: 'teacher')
  end

  def self.office
    find_by(name: 'office')
  end

  def ability_for(resource)
    fetch_perm([resource]).try(:keys).try(:first)
  end

  def fetch_perm(keys = [])
    keys.inject(self.permissions){|permissions, key| permissions && permissions[key] }
  end

  def form_permissions=(form_perms)
    hsh = form_perms.inject({}) do |builder, res_hsh|
      res = {}
      res[res_hsh.first] = {res_hsh.last['ability'] => res_hsh.last['level']}
      builder.merge!(res)
    end
    self.permissions = hsh
  end
end
