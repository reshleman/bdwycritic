require "rails_helper"

feature "Guest views event" do
  scenario "and sees event summary information" do
    event = create(:event, :without_closing_date)

    visit event_path(event)

    expect(page).to have_css ".event-description", text: event.name
    expect(page).to have_css ".event-description", text: event.description
    expect(page).to have_css ".event-details", text: event.venue
    expect(page).to have_css ".event-details", text: "Open run"
  end

  scenario "and sees media reviews for that event" do
    event = create(:event, :with_media_reviews)
    num_media_reviews = event.media_reviews.count
    media_review = event.media_reviews.first

    visit event_path(event)

    expect(page).to have_link(
      media_review.headline,
      href: media_review.url,
      count: num_media_reviews
    )
    expect(page).to have_css(
      ".media-review",
      text: media_review.score,
      count: num_media_reviews
    )
    expect(page).to have_css(
      ".media-review",
      text: media_review.author,
      count: num_media_reviews
    )
  end

  scenario "and sees user reviews for that event" do
    event = create(:event, :with_user_reviews)
    num_user_reviews = event.user_reviews.count
    user_review = event.user_reviews.first

    visit event_path(event)

    expect(page).to have_user_review_score(user_review.score, num_user_reviews)
    expect(page).to have_user_review_body(user_review.body, num_user_reviews)
  end

  scenario "and does not see reviews for other events" do
    event = create(:event)
    user_review = create(:user_review)
    media_review = create(:media_review)

    visit event_path(event)

    expect(page).not_to have_user_review_body(user_review.body)
    expect(page).not_to have_text media_review.headline
  end
end
