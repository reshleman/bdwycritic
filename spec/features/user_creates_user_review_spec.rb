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
    expect(page).to have_user_review_content(user_review.body)
    expect(page).to have_user_review_content(user.first_name)
  end

  def have_user_review_score(score)
    have_css(".user-review .review-score", text: score)
  end

  def have_user_review_content(text)
    have_css(".user-review .review-content", text: text)
  end
end
