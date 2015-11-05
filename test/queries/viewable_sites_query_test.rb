require 'test_helper'

class ViewableSitesQueryTest < ActiveSupport::TestCase

  test "Multisite teachers only see their sites" do
    user = users(:rsp_teacher)
    query = ViewableSitesQuery.new(user)
    assert_equal 2, query.sites.count
  end

  test "Single site teachers only get their one site" do
    user = users(:ashley_doe)
    query = ViewableSitesQuery.new(user)
    assert_equal 1, query.sites.count
  end
end
