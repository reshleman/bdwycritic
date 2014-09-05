class Event < ActiveRecord::Base
  has_many :event_preferences
  has_many :user_reviews, dependent: :destroy
  has_many :media_reviews, dependent: :destroy
  has_one :review_statistics_summary, foreign_key: :event_id

  validates :name, presence: true
  validates :nyt_event_id, uniqueness: true, allow_blank: true

  delegate :average_user_review,
    :average_media_review,
    :average_user_review_score,
    :average_media_review_score,
    to: :review_statistics_summary

  default_scope { includes(:review_statistics_summary) }

  def self.current
    where("closing_date IS NULL OR closing_date >= ?", Date.today)
  end

  def self.closed
    where("closing_date < ?", Date.today)
  end

  def self.search(event_name)
    where("name ILIKE ?", "%#{event_name}%")
  end

  def self.by_average_media_review
    joins(:review_statistics_summary).
    where("average_media_review IS NOT NULL").
    order("average_media_review DESC")
  end

  def self.by_average_user_review
    joins(:review_statistics_summary).
    where("average_user_review IS NOT NULL").
    order("average_user_review DESC")
  end

  def nyt_date_older_than?(date)
    nyt_updated_at < date
  end
end
