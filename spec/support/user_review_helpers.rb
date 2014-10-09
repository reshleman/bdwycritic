module UserReviewHelpers
  def expect_user_review_score_to_update_from(old_value, new_value)
    expect(page).not_to have_user_review_score(old_value)
    expect(page).to have_user_review_score(new_value)
  end

  def expect_user_review_body_to_update_from(old_value, new_value)
    expect(page).not_to have_user_review_body(old_value)
    expect(page).to have_user_review_body(new_value)
  end

  def have_user_review_score(score, count = 1)
    have_css(".user-review .review-score", text: score, count: count)
  end

  def have_user_review_body(text, count = 1)
    have_css(".user-review .review-content", text: text, count: count)
  end
end
