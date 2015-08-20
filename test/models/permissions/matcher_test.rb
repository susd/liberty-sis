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

  test "Finds resource level" do
    assert_equal @own, @matcher.resource_level(:classrooms)
  end

  test "Level match" do
    assert @matcher.target_level_match?(:own, @classroom)
  end

  test "has ability over target" do
    assert @matcher.has_ability_over?(@classroom)
  end

  test "Finds target ability" do
    assert_equal @edit, @matcher.target_ability(@classroom)
  end

  test "Matches all scope" do
    matcher = Permissions::Matcher.new(users(:admin))
    assert matcher.match_all_scope(Classroom.new)
  end

  # test "Matches site scope" do
  #   matcher = Permissions::Matcher.new(users(:office))
  #   assert matcher.match_site_scope(Classroom.new)
  # end

  test "Match general" do
    matcher = Permissions::Matcher.new(users(:admin))
    assert matcher.match_general?(:view, :own, :classrooms)
  end

end
