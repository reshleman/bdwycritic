module EventSummaryHelpers
  def have_event_summary(event)
    have_css(".event", text: event.name) &&
    have_css(".event", text: event.venue)
  end

  def expect_page_to_have_review_summaries_for(event)
    expect_page_to_have_media_review_summary_for(event)
    expect_page_to_have_user_review_summary_for(event)
  end

  def expect_page_to_have_media_review_summary_for(event)
    within(".review-score", text: "Critics") do
      expect(page).to have_text(event.average_media_review_score)
      expect(page).to have_review_count(event.media_reviews.count)
    end
  end

  def expect_page_to_have_user_review_summary_for(event)
    within(".review-score", text: "Users") do
      expect(page).to have_text(event.average_user_review_score)
      expect(page).to have_review_count(event.user_reviews.count)
    end
  end

  def have_review_count(count)
    have_text("#{count} Reviews")
  end
end
