require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:one)
  end

  test "should get user registeration" do
    get new_user_registration_path
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post user_registration_url, params: { user: { username: "bob", email: "bob@gmail.com", password: "112233" } }
    end

    assert_redirected_to root_url
  end

  test "should get user login" do
    get new_user_session_path
    assert_response :success
  end

  test "should sign out user" do
    sign_in(@user)
    delete destroy_user_session_url
    assert_redirected_to root_path
  end
end
