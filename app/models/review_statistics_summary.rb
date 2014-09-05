class ReviewStatisticsSummary < ActiveRecord::Base
  self.table_name = "event_review_statistics"
  self.primary_key = "event_id"

  belongs_to :event

  def average_user_review_score
    @average_user_review_score ||= UserReviewScore.new(average_user_review)
  end

  def average_media_review_score
    @average_media_review_score ||= MediaReviewScore.new(average_media_review)
  end
end
