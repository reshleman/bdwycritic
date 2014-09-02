module ReviewsHelper
  def user_review_score_block(score)
    converted_score = format_user_review_score(score)

    content_tag(
      :div,
      converted_score,
      class: user_review_css_class(converted_score)
    )
  end

  def media_review_score_block(score)
    converted_score = format_media_review_score(score)

    content_tag(
      :div,
      converted_score,
      class: media_review_css_class(converted_score)
    )
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
end
