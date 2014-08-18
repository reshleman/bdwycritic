class Event < ActiveRecord::Base
  has_many :user_reviews

  validates :name, presence: true
end
