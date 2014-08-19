module NytEventListings
  class Query
    def initialize(options)
      @options = options
    end

    def execute
      NytEventListings::Result.new(HTTParty::get(URL, query_params))
    end

    private

    attr_reader :options

    def query_params
      { query: @options.merge("api-key" => API_KEY) }
    end
  end
end
