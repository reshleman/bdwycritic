class Event < ActiveRecord::Base
  has_many :user_reviews
  has_many :media_reviews

  validates :name, presence: true
end
