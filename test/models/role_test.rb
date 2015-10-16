# == Schema Information
#
# Table name: roles
#
#  id          :integer          not null, primary key
#  name        :text
#  permissions :jsonb            default({}), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  test "saving permissions from form" do
    role = Role.new

    role.form_permissions = form_params

    assert_equal expected_perms, role.permissions
  end

  private

  def form_params
    {
      "sites"=>{"ability"=>"none", "level"=>"none"},
      "employees"=>{"ability"=>"none", "level"=>"none"},
      "classrooms"=>{"ability"=>"manage", "level"=>"own"},
      "students"=>{"ability"=>"none", "level"=>"none"}
    }
  end

  def expected_perms
    {
      "sites"=>{"none" => "none"},
      "employees"=>{"none" => "none"},
      "classrooms"=>{"manage" => "own"},
      "students"=>{"none" => "none"}
    }
  end
end
