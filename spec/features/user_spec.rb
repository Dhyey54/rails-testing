require 'rails_helper'

RSpec.feature "Users", type: :feature do
  let(:user) { create(:user) }

  scenario "user sign-in" do
    visit new_user_session_path
    fill_in 'Username', with: user.username
    fill_in 'Password', with: user.password

    click_button "Log in"
    expect(current_path).to eq(root_path)
    expect(page).to have_content "Welcome, #{user.username}"
  end

  scenario "user sign-in with wrong credentials" do
    visit new_user_session_path
    fill_in 'Username', with: "user.username"
    fill_in 'Password', with: "user.password"

    click_button "Log in"
    expect(current_path).to eq(current_path)
    expect(page).to have_content "Invalid Username or password"
  end
end
