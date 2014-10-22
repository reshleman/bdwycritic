ENV["RAILS_ENV"] ||= "test"
require "spec_helper"
require File.expand_path("../../config/environment", __FILE__)
require "rspec/rails"
require "vcr"
require "webmock/rspec"

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data("<ALCHEMY_API_KEY>") do
    ENV['ALCHEMY_API_KEY']
  end
end

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

Monban.test_mode!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.include FactoryGirl::Syntax::Methods
  config.include Monban::Test::ControllerHelpers, type: :controller
  config.include MediaReviewHelpers, type: :feature
  config.include UserReviewHelpers, type: :feature
  config.include EventSummaryHelpers, type: :feature

  config.after do
    Monban.test_reset!
  end
end
