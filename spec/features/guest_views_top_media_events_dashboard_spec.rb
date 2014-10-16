require "rails_helper"

feature "Guest views top media events dashboard" do
  scenario "and sees open events with media reviews" do
    event = create(:event, :with_reviews, :open)

    visit root_path
    click_link "Critics Recommend"

    expect(page).to have_event_summary(event)
    expect_page_to_have_review_summaries_for(event)
  end

  scenario "and does not see open events with no media reviews" do
    event = create(:event, :with_user_reviews, :open)

    visit root_path
    click_link "Critics Recommend"

    expect(page).not_to have_event_summary(event)
  end

  scenario "and does not see closed events" do
    event = create(:event, :closed)

    visit root_path
    click_link "Critics Recommend"

    expect(page).not_to have_event_summary(event)
  end
end
