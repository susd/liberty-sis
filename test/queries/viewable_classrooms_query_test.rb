require 'test_helper'

class ViewableClassroomsQueryTest < ActiveSupport::TestCase

  test "scope classrooms for user that can view all classrooms" do
    expected = Classroom.order(:site_id, :name)
    assert_equal expected, ViewableClassroomsQuery.new(users(:admin)).user_classrooms
  end

  test "scope for user that can view site classrooms" do
    expected = Classroom.where(site: sites(:west_creek)).order(:site_id, :name).to_a
    assert_equal expected, ViewableClassroomsQuery.new(users(:office)).user_classrooms.to_a
  end
end
