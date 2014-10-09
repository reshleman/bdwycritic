require "rails_helper"

feature "User can edit a user review from an event page" do
  before do
    @event = create(:event)
    @user = create(:user)
  end

  scenario "User edits their own review for an event" do
    user_review = create(:user_review, event: @event, user: @user)
    new_rating = user_review.rating - 1
    new_body = "Changed review text."

    visit_event
    find(".user-review").click_link("Edit")
    select(new_rating, from: "Rating")
    fill_in "Body", with: new_body
    click_button "Update Review"

    expect_user_review_score_to_update_from(user_review.score, new_rating)
    expect_user_review_body_to_update_from(user_review.body, new_body)
  end

  scenario "User does not see edit option for reviews they did not create" do
    other_user = create(:user)
    user_review = create(:user_review, event: @event, user: other_user)

    visit_event

    expect(page).to have_content(user_review.body)
    expect(page).not_to have_css(".user-review", text: "Edit")
  end

  def visit_event
    visit event_path(@event, as: @user)
  end
end
