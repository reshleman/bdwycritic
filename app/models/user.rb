class User < ActiveRecord::Base
  has_many :user_reviews
  has_many :reviewed_events, through: :user_reviews, source: :event

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  def reviewed?(event)
    reviewed_events.include?(event)
  end
end
