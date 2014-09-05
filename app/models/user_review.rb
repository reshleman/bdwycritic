class UserReview < ActiveRecord::Base
  belongs_to :user
  belongs_to :event, counter_cache: :num_user_reviews

  validates :body, presence: true
  validates :event, presence: true
  validates :rating,
    presence: true,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 10
    }
  validates :user,
    presence: true,
    uniqueness: {
      scope: :event,
      message: "can only review an event once"
    }

  default_scope { order(created_at: :desc) }

  def score
    @score ||= UserReviewScore.new(rating)
  end
end
