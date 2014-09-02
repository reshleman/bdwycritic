class UserReviewScore < ReviewScore
  def initialize(user_review_value)
    @score = user_review_value || 0
  end

  def category
    case score
    when 0 then nil
    when 0.0...4.0 then :negative
    when 4.0...7.0 then :neutral
    when 7.0..10.0 then :positive
    end
  end
end
