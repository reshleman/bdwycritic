module ReviewsHelper
  def captioned_review_score_block(score, num_reviews, caption)
    content_tag :div, class: review_score_css_class(score) do
      review_score_caption(caption) +
      score +
      num_reviews_caption(num_reviews)
    end
  end

  def review_score_block(score)
    content_tag :div, score, class: review_score_css_class(score)
  end

  def review_score_block(score)
    content_tag :div, score, class: review_score_css_class(score)
  end

  private

  def review_score_css_class(score)
    "review-score #{score.category}"
  end

  def num_reviews_caption(num_reviews)
    review_score_caption(pluralize(num_reviews, "Review"))
  end

  def review_score_caption(text)
    content_tag(:div, text, class: "review-score-caption")
  end
end
