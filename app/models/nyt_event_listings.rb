module NytEventListings
  VERSION = "v2"
  BASE_URL = "http://api.nytimes.com/svc/events/#{VERSION}"
  ENDPOINT = "/listings"
  URL = BASE_URL + ENDPOINT
  API_KEY = ENV["NYT_EVENTS_API_KEY"]
end
