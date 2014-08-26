class AnalyzedMediaReview
  attr_reader :analyzed_text

  def initialize(review)
    @review = review
    extract_metadata
    analyze_sentiment
  end

  def save
    review.save
  end

  def headline
    review.headline
  end

  def author
    review.author
  end

  def sentiment
    review.sentiment
  end

  def url
    review.url
  end

  def source
    review.source
  end

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
