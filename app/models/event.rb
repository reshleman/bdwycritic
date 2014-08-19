class Event < ActiveRecord::Base
  has_many :user_reviews
  has_many :media_reviews

  validates :name, presence: true

  def self.current
    where("closing_date >= ?", Date.today)
  end

  def self.closed
    where("closing_date < ?", Date.today)
  end
end
