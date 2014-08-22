class User < ActiveRecord::Base
  has_many :event_preferences
  has_many :user_reviews
  has_many :reviewed_events, through: :user_reviews, source: :event

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  def can_review?(event)
    reviewed_events.exclude?(event)
  end

  def has_no_preference_for?(event)
    !event_preferences.exists?(event: event)
  end

  def wants_to_see?(event)
    preference = preference_for(event)
    preference.present? && preference.wants_to_see?
  end

  def does_not_want_to_see?(event)
    preference = preference_for(event)
    preference.present? && !preference.wants_to_see?
  end

  def create_or_update_preference(event, wants_to_see)
    preference = event_preferences.find_or_initialize_by(event: event)
    preference.wants_to_see = wants_to_see
    preference.save
  end

  private

  def preference_for(event)
    event_preferences.find_by(event: event)
  end
end
