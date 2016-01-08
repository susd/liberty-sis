# == Schema Information
#
# Table name: students
#
#  id                :integer          not null, primary key
#  first_name        :string
#  last_name         :string
#  middle_name       :string
#  sex               :string
#  birthdate         :date
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
#  import_details    :jsonb            not null
#  state             :integer          default(0), not null
#  ssid              :integer
#

require 'test_helper'

class StudentsControllerTest < ActionController::TestCase

  setup do
    @user = users(:ashley_doe)
  end

  test "should get redirected if not signed in" do
    get :show, id: students(:long_name)
    assert_redirected_to new_user_session_path
  end

  test "should get show" do
    sign_in @user

    get :show, id: students(:cindy)
    assert_response :success

    sign_out @user
  end

  test "should get rejected" do
    sign_in @user

    get :show, id: students(:hector)
    assert_redirected_to forbidden_path

    sign_out @user
  end

end
