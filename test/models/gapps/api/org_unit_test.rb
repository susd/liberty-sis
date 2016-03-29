require "test_helper"

class Gapps::Api::OrgUnitTest < ActiveSupport::TestCase

  def setup
    stub_request(:any, /googleapis.com/).to_rack(FakeGoogle)
  end

  test "listing OUs" do
    GAdmin::DirectoryService.any_instance.expects(:list_org_units).with("my_customer", type: "all")
    Gapps::Api::OrgUnit.list
  end

  test "finding an OU" do
    result = Gapps::Api::OrgUnit.find("students")

    assert_requested :get, "#{url_base}/students"
    assert_equal "students", result.name
  end

  test "inserting a top level OU" do
    ou = Gapps::OrgUnit.create(name: 'test_ou')
    expected_body = {
      "name" => "test_ou",
      "parentOrgUnitPath" => "/"
    }

    assert_nil ou.gapps_id

    api_ou = Gapps::Api::OrgUnit.new(ou)
    api_ou.insert

    assert_requested(:post, url_base, body: expected_body)
    assert_equal "id:03b1oz101begoyf", ou.gapps_id
  end

  test "inserting a child OU" do
    ou = Gapps::OrgUnit.create(name: "test_child", parent: gapps_org_units(:test))
    api_ou = Gapps::Api::OrgUnit.new(ou)
    api_ou.insert

    expected_body = {
      "name" => "test_child",
      "parentOrgUnitPath" => "/test_stub",
      "parentOrgUnitId" => "id:03b1oz101x48lv1"
    }

    assert_requested(:post, url_base, body: expected_body)
    assert_equal "id:03b1oz101x48lv1", ou.gapps_parent_id
    assert_equal "/test_stub", ou.gapps_parent_path
  end

  test "importing OUs" do
    start_count = (Gapps::OrgUnit.count + 6)
    Gapps::Api::OrgUnit.import
    Gapps::Api::OrgUnit.import

    # non-existent OUs are created
    assert_includes Gapps::OrgUnit.pluck(:name), "West Creek"
    assert_not_nil Gapps::OrgUnit.find_by(name: "West Creek").synced_at

    # existing OUs are updated
    assert_equal start_count, Gapps::OrgUnit.count
    assert_equal 1, Gapps::OrgUnit.where(name: "students").count

    # OUs are put in hierarchy
    dev = Gapps::OrgUnit.find_by(name: "devices")
    assert_includes dev.children.pluck(:name), "kiosk"
  end

  test "Upsert an OU" do
    ou = gapps_org_units(:child2)
    ou.update(description: "patch test", parent: gapps_org_units(:test))

    Gapps::Api::OrgUnit.new(ou).upsert

    expected_body = {
      "name" => "test_child2",
      "description" => "patch test",
      "parentOrgUnitPath" => "/test_stub",
      "parentOrgUnitId" => "id:03b1oz101x48lv1"
    }

    assert_requested(:patch, "#{url_base}", body: expected_body)
  end

  private

  def read_fixture(name)
    File.open(Rails.root.join("test", "support", "fixtures", name), "rb").read
  end

  def url_base
    "https://www.googleapis.com/admin/directory/v1/customer/my_customer/orgunits"
  end

end
