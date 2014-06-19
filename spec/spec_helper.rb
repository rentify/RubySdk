require_relative '../lib/judopay'

require 'factory_girl'
require 'factories'
require 'webmock/rspec'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include WebMock::API
end

# Use Judopay default configuration
Judopay.configure

def stub_get(path)
  stub_request(:get, /judopay/i)
end

def stub_post(path)
  stub_request(:post, /judopay/i)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end