class AnalyzedMediaReview
  attr_reader :analyzed_text

  def initialize(review)
    @review = review
    extract_metadata
    analyze_sentiment
  end

  delegate :save, :headline, :author, :sentiment, :url, :source, to: :review

  private

  attr_reader :review

  def extract_metadata
    extractor = UrlMetadataExtractor.new(review.url)

    review.headline = extractor.title.titleize
    review.author = extractor.author.titleize
  end

  def analyze_sentiment
    analyzer = SentimentAnalyzer.new(review.url)

    review.sentiment = analyzer.score
    @analyzed_text = analyzer.analyzed_text
  end
end
