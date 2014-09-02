module ReviewsHelper
  def captioned_user_review_score_block(score, num_reviews)
    converted_score = format_user_review_score(score)

    content_tag :div, class: user_review_css_class(converted_score) do
      review_score_caption("Users") +
      converted_score +
      num_reviews_caption(num_reviews)
    end
  end

  def captioned_media_review_score_block(score, num_reviews)
    converted_score = format_media_review_score(score)

    content_tag :div, class: media_review_css_class(converted_score) do
      review_score_caption("Critics") +
      converted_score +
      num_reviews_caption(num_reviews)
    end
  end

  def user_review_score_block(score)
    converted_score = format_user_review_score(score)

    content_tag :div, class: user_review_css_class(converted_score) do
      converted_score
    end
  end

  def media_review_score_block(score, num_reviews = nil)
    converted_score = format_media_review_score(score)

    content_tag :div, class: media_review_css_class(converted_score) do
      converted_score
    end
  end

  def format_media_review_score(score)
    # Convert score proportionally from (-1..1) to (0..100)
    format_review_score(((score || -1) + 1) * 50)
  end

  def format_user_review_score(score)
    format_review_score(score || 0)
  end

  private

  def user_review_css_class(score)
    case score.to_f
    when 0.0...4.0 then "review-score-negative"
    when 4.0...7.0 then "review-score-neutral"
    when 7.0..10.0 then "review-score-positive"
    else "review-score"
    end
  end

  def media_review_css_class(score)
    case score.to_f
    when 0.0...40.0 then "review-score-negative"
    when 40.0...60.0 then "review-score-neutral"
    when 60.0..100.0 then "review-score-positive"
    else "review-score"
    end
  end

  def format_review_score(score)
    number_with_precision(score, precision: 1, strip_insignificant_zeros: true)
  end

  def num_reviews_caption(num_reviews)
    review_score_caption(pluralize(num_reviews, "Review"))
  end

  def review_score_caption(text)
    content_tag(:div, text, class: "review-score-caption")
  end
end
