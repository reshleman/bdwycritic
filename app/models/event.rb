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
    select("COUNT(media_reviews.id) AS num_media_reviews").
    select("COUNT(user_reviews.id) AS num_user_reviews").
    select("AVG(media_reviews.sentiment) AS average_media_review").
    select("AVG(user_reviews.rating) AS average_user_review").
    joins("LEFT OUTER JOIN media_reviews ON events.id = media_reviews.event_id").
    joins("LEFT OUTER JOIN user_reviews ON events.id = user_reviews.event_id").
    group("events.id")
  end

  def nyt_date_older_than?(date)
    nyt_updated_at < date
  end
end
