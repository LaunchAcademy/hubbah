require 'rspec'
require 'mocha/api'
require 'hubbah'

require 'dotenv'
require 'pry'
Dotenv.load

Hubbah.configure do |config|
  config.api_key = ENV['HUBBAH_API_KEY']
  config.hub_id = ENV['HUBBAH_HUB_ID']
end

Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.mock_framework = 'mocha'
end
