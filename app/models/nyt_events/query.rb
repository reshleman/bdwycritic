module NytEvents
  class Query
    DEFAULT_OPTIONS = { "api-key" => API_KEY }

    def initialize(options)
      @query_params = { query: options.merge(DEFAULT_OPTIONS) }
      @query_result = perform_query
    end

    def events
      query_result.fetch("results", []).map do |event|
        NytEvents::Event.new(event)
      end
    end

    private

    attr_reader :query_params, :query_result

    def perform_query
      HTTParty::get(URL, query_params)
    end
  end
end
