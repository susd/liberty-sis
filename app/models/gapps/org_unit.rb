# == Schema Information
#
# Table name: gapps_org_units
#
#  id                :integer          not null, primary key
#  name              :string
#  description       :text
#  parent_id         :integer
#  gapps_id          :string
#  gapps_path        :string
#  gapps_parent_id   :string
#  gapps_parent_path :string
#  synced_at         :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  state             :integer          default(0), not null
#

class Gapps::OrgUnit < ActiveRecord::Base
  enum state: {pending: 0, active: 1, errored: 2, disabled: 3}

  def self.new_from_api(api_obj)
    new({
      name:         api_obj.name,
      description:  api_obj.description,
      gapps_id:     api_obj.org_unit_id,
      gapps_path:   api_obj.org_unit_path,
      gapps_parent_id: api_obj.parent_org_unit_id,
      gapps_parent_path: api_obj.parent_org_unit_path
      })
  end

  def self.create_from_api(api_obj)
    new_from_api(api_obj).save!
  end

end
