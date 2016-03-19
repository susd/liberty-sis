require "test_helper"

class Gapps::Api::OrgUnitTest < ActiveSupport::TestCase

  def setup
    stub_request(:any, /googleapis.com/).to_rack(FakeGoogle)
  end

  test "listing OUs" do
    GAdmin::DirectoryService.any_instance.expects(:list_org_units).with("my_customer")
    Gapps::Api::OrgUnit.list
  end

  test "finding an OU" do
    result = Gapps::Api::OrgUnit.find("students")

    assert_requested :get, "#{url_base}/students"
    assert_equal "students", result.name
  end

  test "inserting an OU" do
    ou = Gapps::OrgUnit.new(name: 'test_ou')
    api_ou = Gapps::Api::OrgUnit.new(ou)
    api_ou.insert

    assert_requested(:post, "#{url_base}", body: {name: "test_ou"}.to_json)
  end

  test "importing OUs" do
    Gapps::Api::OrgUnit.import
    Gapps::Api::OrgUnit.import

    # non-existent OUs are created
    assert_includes Gapps::OrgUnit.pluck(:name), "West Creek"

    # existing OUs are updated
    assert_equal 8, Gapps::OrgUnit.count
    assert_equal 1, Gapps::OrgUnit.where(name: "students").count

    # OUs are put in hierarchy
    dev = Gapps::OrgUnit.find_by(name: "devices")
    assert_includes dev.children.pluck(:name), "kiosk"
  end

  private

  def read_fixture(name)
    File.open(Rails.root.join("test", "support", "fixtures", name), "rb").read
  end

  def url_base
    "https://www.googleapis.com/admin/directory/v1/customer/my_customer/orgunits"
  end

end
