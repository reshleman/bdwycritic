class AnalyzedMediaReviewFactory
  def initialize(review_params)
    @review_params = review_params
  end

  def build
    extract_metadata
    analyze_sentiment

    AnalyzedMediaReview.new(
      MediaReview.new(review_params_with_metadata_and_sentiment),
      analyzed_text
    )
  end

  private

  attr_reader :review_params, :author, :headline, :sentiment, :analyzed_text

  def url
    review_params[:url]
  end

  def extract_metadata
    extractor = UrlMetadataExtractor.new(url)

    @headline = extractor.title.titleize
    @author = extractor.author.titleize
  end

  def analyze_sentiment
    analyzer = SentimentAnalyzer.new(url)

    @sentiment = analyzer.score
    @analyzed_text = analyzer.analyzed_text
  end

  def review_params_with_metadata_and_sentiment
    review_params.
      merge(metadata_params).
      merge(sentiment_params)
  end

  def metadata_params
    {
      headline: headline,
      author: author
    }
  end

  def sentiment_params
    { sentiment: sentiment }
  end
end
