class User < ActiveRecord::Base
  has_many :event_preferences
  has_many :user_reviews
  has_many :reviewed_events, through: :user_reviews, source: :event

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  def can_review?(event)
    reviewed_events.exclude?(event)
  end
end
