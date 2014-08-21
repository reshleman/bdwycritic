class SentimentAnalyzer
  BASE_URL = "http://text-processing.com/api"
  ENDPOINT = "/sentiment/"
  URL = BASE_URL + ENDPOINT

  def initialize(text)
    @post_params = { body: { text: URI::encode_www_form_component(text) } }
    @query_result = perform_query
  end

  def positive
    query_result["probability"]["pos"]
  end

  def negative
    query_result["probability"]["neg"]
  end

  def neutral
    query_result["probability"]["neutral"]
  end

  private

  attr_reader :post_params, :query_result

  def perform_query
    HTTParty::post(URL, post_params)
  end
end
