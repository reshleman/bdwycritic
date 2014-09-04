class MediaReview < ActiveRecord::Base
  belongs_to :event, counter_cache: :num_media_reviews

  validates :event, presence: true
  validates :headline, presence: true
  validates :source, presence: true
  validates :url, presence: true

  def score
    @score ||= MediaReviewScore.new(sentiment)
  end
end
