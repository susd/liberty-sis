require "test_helper"

class Gapps::Api::OrgUnitTest < ActiveSupport::TestCase

  def setup
    # stub_request(:post, "https://www.googleapis.com/oauth2/v3/token")
    #   .with(body: hash_including("assertion" => /.*/))
    #   .to_return(:status => 200, :body => "", :headers => {})
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

  private

  def read_fixture(name)
    File.open(Rails.root.join("test", "support", "fixtures", name), "rb").read
  end

  def url_base
    "https://www.googleapis.com/admin/directory/v1/customer/my_customer/orgunits"
  end

end
