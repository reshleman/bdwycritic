class Event < ActiveRecord::Base
  has_many :user_reviews
  has_many :media_reviews

  validates :name, presence: true
  validates :nyt_event_id, uniqueness: true, allow_blank: true

  def self.current
    where("closing_date IS NULL OR closing_date >= ?", Date.today)
  end

  def self.closed
    where("closing_date < ?", Date.today)
  end

  def older_than_nyt?(date)
    nyt_updated_at < date
  end
end
