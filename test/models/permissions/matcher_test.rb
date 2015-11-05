require 'test_helper'

class Permissions::MatcherTest < ActiveSupport::TestCase

  setup do
    @user = users(:ashley_doe)
    @matcher = Permissions::Matcher.new(@user)
    @classroom = classrooms(:ashleys_class)

    @all = Permissions::Ability.new(:all)
    @edit = Permissions::Ability.new(:edit)

    @own = Permissions::Level.new(:own)
  end

  test "Finds resource ability" do
    assert_equal @edit, @matcher.resource_ability(:classrooms)
  end

  test "Level match" do
    assert @matcher.target_in_level?(:own, @classroom)
  end

  test "Finds target ability" do
    assert_equal @edit, @matcher.ability_for(@classroom)
  end

  test "Match all scope" do
    matcher = Permissions::Matcher.new(users(:admin))
    assert matcher.match_all_scope(@classroom)
  end

  test "General matching" do
    assert @matcher.match_general?(:view, :own, :classrooms)
  end

  test "Target matching" do
    assert @matcher.match_target?(:view, @classroom)
  end

  test "Cannot view classroom" do
    assert_not @matcher.match_target?(:view, classrooms(:alices_class))
  end

  test "Cannot manage sites" do
    assert_not @matcher.match_general?(:manage, :all, :sites)
  end

  test "Cannot manage all classrooms" do
    assert_not @matcher.match_general?(:manage, :all, :classrooms)
  end

  test "RSP should not be able to manage a classroom she can view" do
    matcher = Permissions::Matcher.new(users(:rsp_teacher))
    assert matcher.match_target?(:view, @classroom)
    assert_not matcher.match_target?(:manage, @classroom)
  end

  test "Principal should be able to view students" do
    user = users(:principal)
    matcher = Permissions::Matcher.new(user)

    assert matcher.match_target?(:view, @classroom.students.first)
    assert matcher.match_general?(:view, :site, :students)
  end

end
