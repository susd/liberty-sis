# == Schema Information
#
# Table name: employees
#
#  id              :integer          not null, primary key
#  type            :string
#  first_name      :string
#  last_name       :string
#  sex             :string
#  email           :string
#  birthdate       :date
#  hired_on        :date
#  years_edu       :integer          default(0), not null
#  years_district  :integer          default(0), not null
#  title           :string
#  state           :integer          default(0), not null
#  legacy_id       :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  import_details  :jsonb            not null
#  primary_site_id :integer
#

require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase

  test "Guessing email" do
    user1 = users(:same1)
    emp1 = user1.employee

    emp2 = employees(:same_name2)

    assert emp1.save
    emp1.reload

    assert_equal "cfinkleworth@example.com", emp1.email

    emp2.save
    emp2.reload

    assert_equal "chrisfinkleworth@example.com", emp2.email
  end

  test "Guessing email with hyphenated last_name" do
    emp = employees(:hyphenated)
    emp.save
    emp.reload

    assert_equal "jschmidt@saugususd.org", emp.email
  end

end
