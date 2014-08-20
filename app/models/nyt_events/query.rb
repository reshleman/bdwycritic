module NytEvents
  class Query
    def initialize(options)
      @options = options
      @query_result = perform_query
    end

    def events
      @query_result.fetch("results", []).map do |event|
        NytEvents::Event.new(event)
      end
    end

    def status
      @query_result.response.code.to_i
    end

    def num_results
      @query_result["num_results"]
    end

    private

    attr_reader :options, :query_result

    def perform_query
      HTTParty::get(URL, query_params)
    end

    def query_params
      { query: @options.merge("api-key" => API_KEY) }
    end
  end
end
