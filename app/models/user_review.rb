class UserReview < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :body, presence: true
  validates :event, presence: true
  validates :rating,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 10
    }
  validates :user, presence: true
end
