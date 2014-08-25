AlchemyAPI::configure do |config|
  config.apikey = ENV['ALCHEMY_API_KEY']
  config.output_mode = :json
end

class SentimentAnalyzer
  attr_reader :analyzed_text

  def initialize(url)
    query_response = perform_query(url)

    @sentiments_result = query_response["docSentiment"]
    @analyzed_text = query_response["text"]
  end

  def score
    sentiments_result["score"]
  end

  private

  attr_reader :sentiments_result

  def perform_query(url)
    query = AlchemyAPI::SentimentAnalysis.new
    query.search(url: url, showSourceText: 1)
    JSON.parse(query.response.body)
  end
end
