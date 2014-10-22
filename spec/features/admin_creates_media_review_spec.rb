require "rails_helper"

feature "Admin creates media review" do
  scenario "and sees a summary of the analyzed review" do
    VCR.use_cassette("media_review_metadata") do
      admin = create(:user, :admin)
      event = create(:event)

      visit event_path(event, as: admin)
      create_media_review

      expect_page_to_have_media_review_from_vcr
      expect_page_to_have_media_review_analyzed_text_from_vcr
    end
  end

  scenario "and sees the review on the event's page" do
    VCR.use_cassette("media_review_metadata") do
      admin = create(:user, :admin)
      event = create(:event)

      visit event_path(event, as: admin)
      create_media_review
      click_link "Return to Event"

      expect_page_to_have_media_review_from_vcr
    end
  end

  def create_media_review
    click_link "Add a Critic Review"
    fill_in "URL", with: vcr_media_review_url
    fill_in "Source", with: vcr_media_review_source
    click_button "Add Critic Review"
  end

  def vcr_media_review_url
    "http://nyti.ms/1lDsQDP"
  end

  def vcr_media_review_source
    "New York Times"
  end

  def expect_page_to_have_media_review_from_vcr
    expect(page).to have_media_review_score(56)
    expect(page).to have_media_review_link(vcr_media_review_url, "Hedwig")
    expect(page).to have_media_review_source(vcr_media_review_source)
    expect(page).to have_media_review_author("Ben Brantley")
  end

  def expect_page_to_have_media_review_analyzed_text_from_vcr
    expect(page).to have_media_review_analyzed_text("Do not be alarmed by")
  end
end
