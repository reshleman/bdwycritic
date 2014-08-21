class MediaReview < ActiveRecord::Base
  belongs_to :event

  validates :event, presence: true
  validates :headline, presence: true
  validates :source, presence: true
  validates :url, presence: true

  def self.analyze_new(review_params, review_text)
    new(review_params.merge(sentiments_from(review_text)))
  end

  private

  def self.sentiments_from(text)
    analyzer = SentimentAnalyzer.new(text)
    {
      sentiment_positive: analyzer.positive,
      sentiment_negative: analyzer.negative,
      sentiment_neutral: analyzer.neutral
    }
  end
end
