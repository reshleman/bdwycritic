class MediaReviewMetadataExtractor
  attr_reader :title, :author, :sentiment, :analyzed_text

  def initialize(url)
    @url = url
    @title = title_query_response.titleize
    @author = author_query_response.titleize
    @sentiment = sentiments_query_response["docSentiment"]["score"]
    @analyzed_text = sentiments_query_response["text"]
  end

  private

  attr_reader :url

  def title_query_response
    @title_query_response = AlchemyAPI::TitleExtraction.new.search(url: url)
  end

  def author_query_response
    @author_query_respose = AlchemyAPI::AuthorExtraction.new.search(url: url)
  end

  def sentiments_query_response
    @sentiments_query_response ||= perform_sentiments_query
  end

  def perform_sentiments_query
    query = AlchemyAPI::SentimentAnalysis.new
    query.search(url: url, showSourceText: 1)
    JSON.parse(query.response.body)
  end
end
