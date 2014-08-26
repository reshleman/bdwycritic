class AnalyzedMediaReview
  attr_reader :analyzed_text

  def initialize(review, analyzed_text = "")
    @review = review
    @analyzed_text = analyzed_text
  end

  delegate :save, :headline, :author, :sentiment, :url, :source, to: :review

  private

  attr_reader :review
end
