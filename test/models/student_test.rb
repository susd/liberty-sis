# == Schema Information
#
# Table name: students
#
#  id                :integer          not null, primary key
#  first_name        :string
#  last_name         :string
#  middle_name       :string
#  sex               :string
#  birthdate         :datetime
#  site_id           :integer
#  grade_id          :integer
#  homeroom_id       :integer
#  home_lang_id      :integer
#  ethnicity_id      :integer
#  race_id           :integer
#  family_id         :integer
#  enrollment_status :integer          default(0), not null
#  flag              :integer          default(0), not null
#  legacy_id         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  import_details    :jsonb            default({}), not null
#

require 'test_helper'

class StudentTest < ActiveSupport::TestCase

  setup do
    @student = students(:long_name)
  end

  test "Persona name has no spaces" do
    refute_match /\s/, @student.persona_name
  end

  test "Graduation year calculation" do
    Timecop.travel(Date.new(2015,8,19)) do
      assert_equal '23', @student.grad_year
    end
    Timecop.travel(Date.new(2016,2,1)) do
      assert_equal '23', @student.grad_year
    end
  end

  test "Adding classrooms idempotently" do
    5.times do
      @student.add_classroom(classrooms(:std_classroom))
    end

    assert_equal 1, @student.classrooms.count
  end

end
