# == Schema Information
#
# Table name: gapps_org_units
#
#  id                :integer          not null, primary key
#  name              :string
#  description       :text
#  parent_id         :integer
#  gapps_id          :string
#  gapps_path        :string
#  gapps_parent_id   :string
#  gapps_parent_path :string
#  synced_at         :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  state             :integer          default(0), not null
#

require 'test_helper'

class Gapps::OrgUnitTest < ActiveSupport::TestCase
  test "Create from api" do
    api_obj = GAdmin::OrgUnit.new(name: "3rd_grade")

    assert_difference("Gapps::OrgUnit.count") do
      Gapps::OrgUnit.create_from_api(api_obj)
    end
  end


end
