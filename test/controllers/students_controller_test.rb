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
