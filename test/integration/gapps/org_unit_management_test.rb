require 'test_helper'

class Gapps::OrgUnitManagementTest < ActionDispatch::IntegrationTest
  test "Accessing OrgUnit index" do
    with_user(users(:admin)) do
      visit gapps_org_units_path

      assert page.has_content? "Org Units"
    end
  end

end
