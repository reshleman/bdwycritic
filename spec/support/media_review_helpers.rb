module MediaReviewHelpers
  def have_media_review_score(score)
    have_css(".media-review .review-score", text: score)
  end

  def have_media_review_link(url, title)
    have_link(title, href: url)
  end

  def have_media_review_source(source)
    have_css(".media-review .review-content .review-detail", "#{source} review")
  end

  def have_media_review_author(author)
    have_css(".media-review .review-content .review-detail", "by #{author}")
  end

  def have_media_review_analyzed_text(text)
    have_content "This text was analyzed: #{text}"
  end
end
