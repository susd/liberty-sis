require 'test_helper'

class Permissions::MergerTest < ActiveSupport::TestCase
  setup do
    @merger = Permissions::Merger.new
  end

  test "merging abilities with like levels" do
    abilities = [
      {view: :all},
      {manage: :all}
    ]
    assert_equal({manage: :all}, @merger.ability_merge(abilities))
  end

  test "merging abilities with different levels" do
    abilities = [
      {view: :all},
      {manage: :own}
    ]
    assert_equal({view: :all, manage: :own}, @merger.ability_merge(abilities))
  end

  test "merging same ability different levels" do
    abilities = [
      {view: :all},
      {view: :own}
    ]
    assert_equal({view: :all}, @merger.ability_merge(abilities))
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
    assert_equal expected, @merger.resource_merge(initial)
  end

end
