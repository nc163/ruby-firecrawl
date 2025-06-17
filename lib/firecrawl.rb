# frozen_string_literal: true

require "firecrawl/v1/client"
# require "firecrawl/v2/client"
require "firecrawl/version"

#
module Firecrawl
  class Error < StandardError; end
  class ConfigurationError < Error; end
  class AuthenticationError < Error; end

  class Configuration
    attr_accessor :url, :api_key, :debug
    attr_writer :timeout

    def initialize
      @url = 'https://api.firecrawl.dev'
    end

    def uri
      @uri ||= URI.join(url, "/")
    end
  end

  class << self
    attr_writer :configuration

    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
end
