require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
  end

  test "user should not save if empty" do
    user = User.new
    assert_not user.save, "Saved the user without a title"
  end

  test "username exist" do
    user = User.new(username: @user.username, email: "test@gmail.com", password: "112233")

    assert_not user.save, "Saved the product with existing username"
  end

  test "email exist" do
    user = User.new(username: "test", email: @user.username, password: "112233")

    assert_not user.save, "Saved the product with existing email"
  end

  test "password is less than 6 characters" do
    @user.password = "nil"

    assert_not @user.save, "Saved the user with password less than 6 characters"
  end
end
