require "rails_helper"

feature "Guest views closed events dashboard" do
  scenario "and sees closed events" do
    event = create(:event, :with_reviews, :closed)

    visit root_path
    click_link "Recently Closed"

    expect(page).to have_event_summary(event)
    expect_page_to_have_review_summaries_for(event)
  end

  scenario "and does not see open events" do
    event = create(:event, :open)

    visit root_path
    click_link "Recently Closed"

    expect(page).not_to have_event_summary(event)
  end
end
