require "bundler/setup"
Bundler.setup

require "json"
require "firecrawl"

RSpec.configure do |rspec_config|

  rspec_config.before(:all) do
    Firecrawl::configure do |firecrawl_config|
      firecrawl_config.url = 'http://127.0.0.1:3002'
    end
  end

end


