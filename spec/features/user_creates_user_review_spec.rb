require "rails_helper"

feature "User creates a user review for an event" do
  scenario "and sees their score and text review on the event page" do
    event = create(:event)
    user = create(:user)
    user_review = build(:user_review)

    visit event_path(event, as: user)
    click_link "Write a Review"
    select user_review.score, from: "Rating"
    fill_in "Body", with: user_review.body
    click_button "Add your Review"

    expect(page).to have_user_review_score(user_review.score)
    expect(page).to have_user_review_body(user_review.body)
  end
end
