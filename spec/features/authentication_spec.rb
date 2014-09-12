require "rails_helper"

feature "User signs up" do
  scenario "with valid information" do
    user = build(:user)
    visit root_path
    click_link "Sign up"

    fill_in "First name", with: user.first_name
    fill_in "Last name", with: user.last_name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password_digest
    click_button "Sign up"

    expect_user_to_be_signed_in
    expect_user_not_to_be_admin
  end
end

feature "User signs in" do
  scenario "as an admin with valid credentials" do
    admin_user = create(:user, :admin)
    visit_sign_in_page

    user_signs_in_as(admin_user.email, admin_user.password_digest)

    expect_user_to_be_signed_in
    expect_user_to_be_admin
  end

  scenario "as a normal user with valid credentials" do
    user = create(:user)
    visit_sign_in_page

    user_signs_in_as(user.email, user.password_digest)

    expect_user_to_be_signed_in
    expect_user_not_to_be_admin
  end

  scenario "with invalid credentials" do
    user = create(:user)
    visit_sign_in_page

    user_signs_in_as(user.email, user.password_digest + "incorrect")

    expect_user_not_to_be_signed_in
  end
end

private

def visit_sign_in_page
  visit root_path
  click_link "Sign in"
end

def user_signs_in_as(email, password)
  fill_in "Email", with: email
  fill_in "Password", with: password
  click_button "Sign in"
end

def expect_user_to_be_signed_in
  expect(page).to have_content "Sign out"
  expect(page).not_to have_content "Sign in"
  expect(page).not_to have_content "Sign up"
end

def expect_user_not_to_be_signed_in
  expect(page).to have_content "Sign in"
  expect(page).to have_content "Sign up"
  expect(page).not_to have_content "Sign out"
end

def expect_user_to_be_admin
  expect(page).to have_content "Admin"
end

def expect_user_not_to_be_admin
  expect(page).not_to have_content "Admin"
end
