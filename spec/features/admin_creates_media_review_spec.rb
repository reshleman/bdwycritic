require "rails_helper"

feature "Admin creates media review" do
  scenario "and sees a summary of the analyzed review" do
    VCR.use_cassette("media_review_metadata") do
      admin = create(:user, :admin)
      event = create(:event)
      media_review = build_stubbed(:media_review)

      visit event_path(event, as: admin)
      create_media_review(media_review)

      expect_page_to_have_media_review(media_review)
      expect(page).to have_media_review_analyzed_text(vcr_analyzed_text)
    end
  end

  scenario "and sees the review on the event's page" do
    VCR.use_cassette("media_review_metadata") do
      admin = create(:user, :admin)
      event = create(:event)
      media_review = build_stubbed(:media_review)

      visit event_path(event, as: admin)
      create_media_review(media_review)
      click_link "Return to Event"

      expect_page_to_have_media_review(media_review)
    end
  end

  def create_media_review(media_review)
    click_link "Add a Critic Review"
    fill_in "URL", with: media_review.url
    fill_in "Source", with: media_review.source
    click_button "Add Critic Review"
  end

  def vcr_analyzed_text
    "Do not be alarmed by"
  end
end
