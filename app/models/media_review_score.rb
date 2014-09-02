class MediaReviewScore < ReviewScore
  def initialize(media_review_value)
    @score = ((media_review_value || -1) + 1) * 50
  end

  def category
    case score
    when 0.0 then :""
    when 0.0...40.0 then :negative
    when 40.0...60.0 then :neutral
    when 60.0..100.0 then :positive
    else :""
    end
  end
end
