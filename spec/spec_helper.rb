$: << File.expand_path("../../lib", __FILE__)

require 'mongoid'
require 'mongoid-rspec'
require 'mongoid_token'
require 'database_cleaner-mongoid'

ENV['MONGOID_ENV'] = "test"

RSpec.configure do |config|
  Mongo::Logger.logger.level = Logger::ERROR

  config.include Mongoid::Matchers
  config.before(:suite) do
    DatabaseCleaner[:mongoid].strategy = :deletion
    DatabaseCleaner[:mongoid].clean_with(:deletion)
  end

  config.after(:each) do
    DatabaseCleaner.clean
    Mongoid.purge!
  end
end

Mongoid.configure do |config|
  config.connect_to("mongoid_token_test", {})
end
