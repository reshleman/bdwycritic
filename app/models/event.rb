class Event < ActiveRecord::Base
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

  def nyt_date_older_than?(date)
    nyt_updated_at < date
  end
end
