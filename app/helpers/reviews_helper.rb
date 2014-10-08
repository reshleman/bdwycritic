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

  def review_modify_links_for(user_review)
    content_tag :div, class: "review-modify-links" do
      if current_user.admin?
        admin_modify_links_for(user_review)
      elsif user_review.created_by?(current_user)
        creator_modify_links_for(user_review)
      end
    end
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

  def admin_modify_links_for(user_review)
    link_to("Edit", edit_admin_user_review_path(user_review)) +
    link_to(
      "Delete",
      admin_user_review_path(user_review),
      method: :delete,
      data: { confirm: "Are you sure?" }
    )
  end

  def creator_modify_links_for(user_review)
    link_to "Edit", edit_user_review_path(user_review)
  end
end
