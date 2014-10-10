require "rails_helper"

feature "Admin manages a user review for an event" do
  before do
    @event = create(:event, :with_user_reviews, user_review_count: 1)
    @admin = create(:user, :admin)
    @user_review = @event.user_reviews.first
  end

  scenario "by editing the review rating" do
    new_rating = @user_review.rating - 1

    visit_event_as_admin
    click_edit_link
    select(new_rating, from: "Rating")
    click_update_button

    expect_user_review_score_to_update_from(@user_review.score, new_rating)
  end

  scenario "by editing the review body" do
    new_body = "Changed review text."

    visit_event_as_admin
    click_edit_link
    fill_in "Body", with: new_body
    click_update_button

    expect_user_review_body_to_update_from(@user_review.body, new_body)
  end

  scenario "by deleting the user review" do
    visit_event_as_admin
    find(".user-review").click_link("Delete")

    expect(page).not_to have_css(".user-review")
  end

  def visit_event_as_admin
    visit event_path(@event, as: @admin)
  end

  def click_edit_link
    find(".user-review").click_link("Edit")
  end

  def click_update_button
    click_button "Update Review"
  end
end
