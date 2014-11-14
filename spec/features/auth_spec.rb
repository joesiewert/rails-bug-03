require 'rails_helper'
require 'capybara/rails'

feature 'Auth' do

  scenario 'User can login and out' do
    create_user email: "user@example.com"

    visit root_path
    within(".signin-form") { click_on "Login" }
    expect(page).to have_content("Username / password is invalid")

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    within(".signin-form") { click_on "Login" }
    expect(page).to have_content("user@example.com")
  end

  scenario 'User can register' do
    visit root_path
    click_on "Register"
    fill_in "Name", with: "Joe"
    fill_in "Email", with: "joe@test.com"
    fill_in "Password", with: "1234"
    fill_in "Confirm", with: "1234"
    click_button "Register"
    expect(page).to have_content("Welcome joe@test.com!")
    expect(page).to have_content("You are logged in successfully.")
  end

  scenario 'User registers without email' do
    visit root_path
    click_on "Register"
    fill_in "Name", with: "Joe"
    fill_in "Password", with: "1234"
    fill_in "Confirm", with: "1234"
    click_button "Register"
    expect(page).to have_content("Email can't be blank")
  end
end
