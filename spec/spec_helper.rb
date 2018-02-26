if ENV['CI']
  require 'simplecov'
  SimpleCov.start
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'airbnb_api'
require 'webmock/rspec'

def response_fixture_for(resource)
  File.read("spec/fixtures/responses/#{resource}.json")
end

def fixture_for(resource)
  JSON.parse(response_fixture_for(resource))
end
