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
  API_ATTRS = %i{
    name
    description
    org_unit_id
    org_unit_path
    parent_org_unit_id
    parent_org_unit_path
  }

  enum state: {pending: 0, active: 1, errored: 2, disabled: 3}

  has_closure_tree

  alias_attribute :org_unit_id, :gapps_id
  alias_attribute :org_unit_path, :gapps_path
  alias_attribute :parent_org_unit_id, :gapps_parent_id
  alias_attribute :parent_org_unit_path, :gapps_parent_path

  after_validation :update_parent

  def self.new_from_api(api_obj)
    attrs = api_obj.to_h.slice(*API_ATTRS)
    new(attrs)
  end

  def self.create_from_api(api_obj)
    new_from_api(api_obj).save!
  end

  def self.create_or_update_from_api(api_obj)
    if ou = find_by(gapps_id: api_obj.org_unit_id)
      ou.update_from_api(api_obj)
    else
      create_from_api(api_obj)
    end
  end

  def update_from_api(api_obj)
    self.update(api_obj.to_h.slice(*API_ATTRS))
  end

  def update_parent
    prnt = Gapps::OrgUnit.find_by(gapps_id: self.gapps_parent_id)
    if prnt
      self.parent = prnt
    end
  end


end
