class MediaReviewMetadataExtractor
  def initialize(url)
    @url = url
  end

  def analyzed_text
    sentiments_query_response["text"]
  end

  def author
    AlchemyAPI::AuthorExtraction.new.search(url: url).titleize
  end

  def sentiment
    sentiments_query_response["docSentiment"]["score"]
  end

  def source
    UrlSourceExtractor.new(url).source
  end

  def title
    AlchemyAPI::TitleExtraction.new.search(url: url).titleize
  end

  private

  attr_reader :url

  def sentiments_query_response
    @sentiments_query_response ||= perform_sentiments_query
  end

  def perform_sentiments_query
    query = AlchemyAPI::SentimentAnalysis.new
    query.search(url: url, showSourceText: 1)
    JSON.parse(query.response.body)
  end
end
