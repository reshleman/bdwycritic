class MediaReviewScore
  def initialize(media_review_value)
    @media_review_value = media_review_value
  end

  def to_s
    number_with_precision(media_review_value, precision: 1, strip_insignificant_zeros: true)
  end

  private

  attr_reader :media_review_value
end
