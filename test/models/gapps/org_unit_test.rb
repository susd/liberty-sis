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

require 'test_helper'

class Gapps::OrgUnitTest < ActiveSupport::TestCase
  test "Create from api" do
    api_obj = GAdmin::OrgUnit.new(name: "3rd_grade")

    assert_difference("Gapps::OrgUnit.count") do
      Gapps::OrgUnit.create_from_api(api_obj)
    end
  end

  test "Update from api" do
    api_obj = GAdmin::OrgUnit.new({
      name: "students",
      description: "Updated description",
      org_unit_id: "id:03b1oz101x48lv0"
      })

    ou = gapps_org_units(:students)
    ou.update_from_api(api_obj)

    ou.reload

    assert_equal "Updated description", ou.description
  end

  test "Create or update from API" do
    existing = GAdmin::OrgUnit.new({
      name: "students",
      description: "Lorem ipsum",
      org_unit_id: "id:03b1oz101x48lv0"
      })

    non_exist = GAdmin::OrgUnit.new({
      name: "other",
      description: "Testing",
      org_unit_id: "not_an_id"
      })

    assert_difference("Gapps::OrgUnit.count", 1) do
      Gapps::OrgUnit.create_or_update_from_api(existing)
      Gapps::OrgUnit.create_or_update_from_api(non_exist)
    end

    assert Gapps::OrgUnit.find_by(name: "students").active?
    assert Gapps::OrgUnit.find_by(name: "other").active?
  end

  test "Parent api info is updated with native parent info on save" do
    parent = gapps_org_units(:test)
    ou = Gapps::OrgUnit.create(name: "test_child", parent: parent)

    assert_equal parent.gapps_id, ou.gapps_parent_id
    assert_equal "/test_stub/test_child", ou.gapps_path
    assert_equal "/test_stub", ou.gapps_parent_path

    new_parent = gapps_org_units(:devices)
    ou.update(parent_id: new_parent.id)
    ou.reload

    assert_equal new_parent.gapps_id, ou.gapps_parent_id
    assert_equal "/devices/test_child", ou.gapps_path
    assert_equal "/devices", ou.gapps_parent_path
  end

end
