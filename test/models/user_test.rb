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

  test "Teacher can view classroom" do
    assert @teacher.can?(:view, :classrooms, classrooms(:ashleys_class))
  end

  test "Teacher can view student in her classroom" do
    assert @teacher.can?(:view, :students, students(:alfred))
  end

  test "Teacher can not view another student" do
    assert_not @teacher.can?(:view, :students, students(:jill))
  end

  test "Office manager can view classrooms for her school" do
    assert @office.can?(:view, :classrooms, classrooms(:ashleys_class))
  end
end
