class UserReviewScore
  def initialize(user_review_value)
    @user_review_value = user_review_value
  end

  def to_s
    number_with_precision(user_review_value, precision: 1, strip_insignificant_zeros: true)
  end

  private

  attr_reader :user_review_value
end
