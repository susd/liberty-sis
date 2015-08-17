require 'test_helper'

class PermissionMatcherTest < ActiveSupport::TestCase

  setup do
    @ashley = users(:ashley_doe)
    @matcher = PermissionMatcher.new(users(:admin), :manage, Classroom.new)
  end

  test "merging abilities with like levels" do
    abilities = [
      {view: :all},
      {manage: :all}
    ]
    assert_equal({manage: :all}, @matcher.ability_merge(abilities))
  end

  test "merging abilities with different levels" do
    abilities = [
      {view: :all},
      {manage: :own}
    ]
    assert_equal({view: :all, manage: :own}, @matcher.ability_merge(abilities))
  end

  test "merging same ability different levels" do
    abilities = [
      {view: :all},
      {view: :own}
    ]
    assert_equal({view: :all}, @matcher.ability_merge(abilities))
  end

  test "merging resource abilities" do
    initial = [
      {classrooms: {manage: :all}},
      {classrooms: {view: :own}, employees: {view: :self}}
    ]
    expected = {
      classrooms: {manage: :all, view: :own},
      employees: {view: :self}
    }
    assert_equal expected, @matcher.resource_merge(initial)
  end

  test "Finds resource ability" do
    matcher = room_matcher_from_syms(:ashley_doe)
    assert_equal :edit, matcher.resource_ability.name
  end

  test "Has equal ability over resource" do
    matcher = room_matcher_from_syms(:ashley_doe, :edit)
    assert matcher.meets_requirement?
  end

  test "Has superior ability over resource" do
    matcher = room_matcher_from_syms(:ashley_doe)
    assert matcher.meets_requirement?
  end

  test "Has no ability" do
    matcher = room_matcher_from_syms(:no_rights)
    assert_not matcher.meets_requirement?
  end

  test "Matching :all level" do
    matcher = room_matcher_from_syms(:admin)
    assert matcher.match_all_scope
  end

  test "Matching site level" do
    matcher = room_matcher_from_syms(:office)
    assert matcher.match_site_scope
  end

  test "Match own scope" do
    matcher = room_matcher_from_syms(:ashley_doe)
    assert matcher.match_own_scope
  end

  test "Match self scope" do
    matcher = PermissionMatcher.new(@ashley, :view, employees(:ashley_doe))
    assert matcher.match_self_scope
  end

  test "Able to manage all" do
    matcher = room_matcher_from_syms(:admin, :manage, :std_classroom)
    assert PermissionMatcher.match(users(:admin), :manage, classrooms(:std_classroom))
  end

  test "Not able to manage all" do
    assert_not PermissionMatcher.match(users(:teacher), :manage, classrooms(:std_classroom))
  end

  test "Able to view own classroom" do
    matcher = room_matcher_from_syms(:ashley_doe)
    assert matcher.match?
  end

  test "Able to view student in related classroom" do
    matcher = PermissionMatcher.new(@ashley, :view, students(:cindy))
    assert matcher.match?
  end


  private

  def room_matcher_from_syms(user_sym, req = :view, class_sym = :ashleys_class)
    user = users(user_sym)
    classroom = classrooms(class_sym)
    PermissionMatcher.new(user, req, classroom)
  end

end
