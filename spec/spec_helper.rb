require "bundler/setup"
Bundler.setup

require "json"
require "firecrawl"
require_relative 'supports/fixtures_helper'

RSpec.configure do |rspec_config|
  rspec_config.include FixturesHelper

  rspec_config.before(:all) do
    Firecrawl::configure do |firecrawl_config|
      firecrawl_config.url = 'http://host.docker.internal:3002'
    end
  end

end


