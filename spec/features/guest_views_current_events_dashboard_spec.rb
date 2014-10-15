require "rails_helper"

feature "Guest views current events dashboard" do
  scenario "and sees open events" do
    event = create(:event, :with_reviews, :open)

    visit root_path
    click_link "Current Events"

    expect(page).to have_event_summary(event)
    expect_page_to_have_review_summaries_for(event)
  end

  scenario "and does not see closed events" do
    event = create(:event, :closed)

    visit root_path
    click_link "Current Events"

    expect(page).not_to have_event_summary(event)
  end

end
