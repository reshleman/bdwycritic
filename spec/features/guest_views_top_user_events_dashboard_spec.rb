require "rails_helper"

feature "Guest views top user events dashboard" do
  scenario "and sees open events with user reviews" do
    event = create(:event, :with_reviews, :open)

    visit root_path
    click_link "Theatergoers Love"

    expect(page).to have_event_summary(event)
    expect_page_to_have_review_summaries_for(event)
  end

  scenario "and does not see open events with no user reviews" do
    event = create(:event, :with_media_reviews, :open)

    visit root_path
    click_link "Theatergoers Love"

    expect(page).not_to have_event_summary(event)
  end

  scenario "and does not see closed events" do
    event = create(:event, :closed)

    visit root_path
    click_link "Theatergoers Love"

    expect(page).not_to have_event_summary(event)
  end
end
