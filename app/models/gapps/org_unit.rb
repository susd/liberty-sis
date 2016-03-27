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
  after_validation :update_parent_attrs

  def self.new_from_api(api_obj)
    attrs = api_obj.to_h.slice(*API_ATTRS)
    new(attrs)
  end

  def self.create_from_api(api_obj)
    ou = new_from_api(api_obj)
    ou.synced_at = Time.now
    ou.state = 1
    ou.save!
  end

  def self.create_or_update_from_api(api_obj)
    if ou = find_by(gapps_id: api_obj.org_unit_id)
      ou.update_from_api(api_obj)
    else
      create_from_api(api_obj)
    end
  end

  def self.select_options
    self.order(:gapps_path).pluck(:gapps_path, :id)
  end

  def self.unassigned
    self.find_by(name: "unassigned")
  end

  def self.fallback_path
    if u = unassigned
      u.gapps_path
    else
      "/"
    end
  end

  def update_from_api(api_obj)
    self.assign_attributes(api_obj.to_h.slice(*API_ATTRS))
    self.synced_at = Time.now
    self.state = 1
    self.save
  end

  def update_parent
    if self.changed.include?("gapps_parent_id") && !self.changed.include?("parent_id")
      set_parent_by_gapps_parent_id
      set_path_from_parent
    end
  end

  def update_parent_attrs
    if parent.present? && self.changed.include?("parent_id")
      self.gapps_parent_id = parent.gapps_id
      self.gapps_parent_path = parent.gapps_parent_path
      set_path_from_parent
    end
  end

  def set_parent_by_gapps_parent_id
    prnt = Gapps::OrgUnit.find_by(gapps_id: self.gapps_parent_id)
    if prnt
      self.parent = prnt
    end
  end

  def set_path_from_parent
    if parent.present?
      self.gapps_path = "#{parent.gapps_path}/#{name}"
      self.gapps_parent_path = parent.gapps_path
    end
  end

  def api_attrs_from_parent
    {
      parent_org_unit_id: parent.try(:gapps_id),
      parent_org_unit_path: (parent.try(:gapps_path) || "/")
    }
  end


end
