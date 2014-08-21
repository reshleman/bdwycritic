class MediaReview < ActiveRecord::Base
  belongs_to :event

  validates :event, presence: true
  validates :headline, presence: true
  validates :source, presence: true
  validates :url, presence: true

  def self.new_with_analysis(review_params, review_text)
    new(review_params.merge(sentiments_from(review_text)))
  end

  def self.sentiments_from(text)
    analyzer = SentimentAnalyzer.new(text)
    {
      sentiment_positive: analyzer.positive,
      sentiment_negative: analyzer.negative,
      sentiment_neutral: analyzer.neutral
    }
  end
  private_class_method :sentiments_from
end
