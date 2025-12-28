require "bundler/setup"
Bundler.setup

require 'dotenv/load'
Dotenv.load

require "firecrawl"
require 'vcr'
require 'webmock/rspec'
require_relative 'supports/fixtures_helper'

RSpec.configure do |rspec_config|
  rspec_config.include FixturesHelper

  rspec_config.before(:all) do
    Firecrawl::configure do |config|
      config.url = ENV['FIRECRAWL_ENDPOINT']
    end

    VCR.configure do |config|
      config.cassette_library_dir = "spec/cassettes"
      config.hook_into :webmock
      config.configure_rspec_metadata!
      config.allow_http_connections_when_no_cassette = true
    end
  end

end
