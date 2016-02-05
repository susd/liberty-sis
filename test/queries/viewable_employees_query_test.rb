require 'test_helper'

class ViewableEmployeesQueryTest < ActiveSupport::TestCase

  test "Employees scoped for principal" do
    query = ViewableEmployeesQuery.new(users(:principal))
    assert_includes query.employees, employees(:ashley_doe)
  end
end
