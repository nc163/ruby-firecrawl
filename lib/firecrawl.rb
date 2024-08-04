require "httparty"
require_relative "firecrawl/version"
require_relative "firecrawl/client"
require_relative "firecrawl/api"

#
module Firecrawl
  class Error < StandardError; end
  class ConfigurationError < Error; end

  class Configuration
    attr_accessor :url, :api_key

    def initialize
      @url = 'https://api.firecrawl.dev'
    end
  end

  class << self
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end

end
