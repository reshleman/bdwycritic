AlchemyAPI::configure do |config|
  config.apikey = ENV['ALCHEMY_API_KEY']
  config.output_mode = :json
end
