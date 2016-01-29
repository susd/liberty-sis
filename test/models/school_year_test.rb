require 'test_helper'

class SchoolYearTest < ActiveSupport::TestCase

  test "finding school year" do
    Timecop.travel(Date.new(2015, 8, 12)) do
      assert_equal 2015, SchoolYear.this_year
    end
    Timecop.travel(Date.new(2016, 2, 28)) do
      assert_equal 2015, SchoolYear.this_year
    end
    Timecop.travel(Date.new(2016, 7, 15)) do
      assert_equal 2016, SchoolYear.this_year
    end
  end
end
