# frozen_string_literal: true

require "httparty"
require "firecrawl/client"
require "firecrawl/api/v0/client"
require "firecrawl/version"

#
module Firecrawl

  class Error < StandardError; end
  class ConfigurationError < Error; end

  class Configuration
    attr_accessor :url, :api_key, :debug

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
