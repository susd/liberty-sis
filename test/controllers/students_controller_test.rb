require 'test_helper'

class StudentsControllerTest < ActionController::TestCase

  test "should get redirected if not signed in" do
    get :show, id: students(:long_name)
    assert_redirected_to new_user_session_path
  end

  test "should get show" do
    sign_in users(:ashley_doe)

    get :show, id: students(:cindy)
    assert_response :success

    sign_out users(:ashley_doe)
  end

end
