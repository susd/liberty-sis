# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  email               :string           default(""), not null
#  encrypted_password  :string           default(""), not null
#  remember_created_at :datetime
#  sign_in_count       :integer          default(0), not null
#  current_sign_in_at  :datetime
#  last_sign_in_at     :datetime
#  current_sign_in_ip  :inet
#  last_sign_in_ip     :inet
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  first_name          :text
#  last_name           :text
#  image_url           :text
#  provider            :text
#  uid                 :text
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  setup do
    @teacher = users(:ashley_doe)
    @office = users(:office)
  end

  test "Permissions API" do
    assert @teacher.can?(:view, classrooms(:ashleys_class))
  end

  test "Finding employee" do
    user = users(:ann_dekanter)
    user.find_and_set_employee
    assert_equal user.employee, employees(:ann_dekanter)
  end
end
