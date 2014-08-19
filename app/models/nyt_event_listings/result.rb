module NytEventListings
  class Result
    attr_reader :status, :copyright, :num_results, :results
    alias_method :events, :results

    def initialize(query_result)
      @status = query_result["status"]
      @copyright = query_result["copyright"]
      @num_results = query_result["num_results"]

      @results = query_result["results"].map do |event|
        NytEventListings::Event.new(event)
      end
    end
  end
end
