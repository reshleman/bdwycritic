class MediaReview < ActiveRecord::Base
  belongs_to :event

  validates :event, presence: true
  validates :headline, presence: true
  validates :source, presence: true
  validates :url, presence: true

  attr_reader :analyzed_text

  def self.new_from_url_with_analysis(review_params)
    new(review_params).extract_metadata.analyze
  end

  def extract_metadata
    extractor = UrlMetadataExtractor.new(url)

    self.headline = extractor.title.titleize
    self.author = extractor.author.titleize

    self
  end

  def analyze
    analyzer = SentimentAnalyzer.new(url)

    @analyzed_text = analyzer.analyzed_text
    self.sentiment = analyzer.score

    self
  end
end
