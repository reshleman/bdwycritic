class Event < ActiveRecord::Base
  has_many :event_preferences
  has_many :user_reviews, dependent: :destroy
  has_many :media_reviews, dependent: :destroy

  validates :name, presence: true
  validates :nyt_event_id, uniqueness: true, allow_blank: true

  def self.current
    where("closing_date IS NULL OR closing_date >= ?", Date.today)
  end

  def self.closed
    where("closing_date < ?", Date.today)
  end

  def self.search(event_name)
    where("name ILIKE ?", "%#{event_name}%")
  end

  def self.with_review_statistics
    select("events.*").
    select("AVG(media_reviews.sentiment) AS average_media_review").
    select("AVG(user_reviews.rating) AS average_user_review").
    joins("LEFT JOIN media_reviews ON events.id = media_reviews.event_id").
    joins("LEFT JOIN user_reviews ON events.id = user_reviews.event_id").
    group("events.id")
  end

  def self.with_review_statistics_by_average_media_review
    with_review_statistics.
    having("AVG(media_reviews.sentiment) IS NOT NULL").
    order("average_media_review DESC")
  end

  def nyt_date_older_than?(date)
    nyt_updated_at < date
  end

  def average_user_review_score
    @average_user_review_score ||= UserReviewScore.new(average_user_review)
  end

  def average_media_review_score
    @average_media_review_score ||= MediaReviewScore.new(average_media_review)
  end
end
