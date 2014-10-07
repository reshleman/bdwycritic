require "rails_helper"

feature "Guest searches for an event" do
  scenario "and sees current events with a matching name" do
    event = create(:event, closing_date: 1.day.from_now)

    search_for(event.name)

    expect(page).to have_link event.name
  end

  scenario "and does not see closed events with a matching name" do
    event = create(:event, closing_date: 1.day.ago)

    search_for(event.name)

    expect(page).not_to have_link event.name
  end

  def search_for(text)
    visit root_path
    within(".search-bar") do
      fill_in "Event name", with: text
      find(".submit").click
    end
  end
end
