# == Schema Information
#
# Table name: employees
#
#  id             :integer          not null, primary key
#  type           :string
#  first_name     :string
#  last_name      :string
#  sex            :string
#  email          :string
#  birthdate      :date
#  hired_on       :date
#  years_edu      :integer          default(0), not null
#  years_district :integer          default(0), not null
#  title          :string
#  status         :integer          default(0), not null
#  legacy_id      :integer
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  import_details :jsonb            default({}), not null
#

require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
