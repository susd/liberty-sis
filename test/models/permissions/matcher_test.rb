require 'test_helper'

class Permissions::MatcherTest < ActiveSupport::TestCase

  setup do
    @user = users(:ashley_doe)
    @matcher = Permissions::Matcher.new(@user)

    @edit = Permissions::Ability.new(:edit)
  end

  test "Finds resource ability" do
    assert_equal @edit, @matcher.resource_ability(:classrooms)
  end

  test "Finds target ability" do
    assert_equal @edit, @matcher.target_ability(classrooms(:ashleys_class))
  end

end
