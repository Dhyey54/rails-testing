require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  def setup
    @user = users(:one)
  end

  test "registering user" do
    visit new_user_registration_path

    fill_in 'Username', with: 'bob'
    fill_in 'Email', with: 'bob@gmail.com'
    fill_in "Password",	with: "112233"
    fill_in "Password confirmation",	with: "112233"

    click_on 'Sign up'

    assert_text "bob"
  end

  test "user can not register with wrong details" do
    visit new_user_registration_path

    fill_in 'Username', with: @user.username
    fill_in 'Email', with: @user.email
    fill_in "Password",	with: "1122"
    fill_in "Password confirmation",	with: "112233"

    click_on 'Sign up'

    assert_text "Username has already been taken"
    assert_text "Email has already been taken"
    assert_text "Password is too short"
    assert_text "Password confirmation doesn't match Password"
  end

  test "login user" do
    visit new_user_session_path

    fill_in 'Username', with: @user.username
    fill_in 'Password', with: "112233"

    click_on 'Log in'

    assert_text "dhyey"
  end

  test "wrong user details login" do
    visit new_user_session_path

    fill_in 'Username', with: "aaaa"
    fill_in 'Password', with: "123123"

    click_on 'Log in'

    assert_text "Invalid Username or password"
  end
end
