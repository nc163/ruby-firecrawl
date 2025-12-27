# frozen_string_literal: true

require 'faraday'
require 'error'
require "firecrawl/v0/client"
require "firecrawl/v1/client"
require "firecrawl/v2/client"
require "firecrawl/version"

#
module Firecrawl

  # Configuration class for Firecrawl
  class Configuration
    attr_accessor :host, :port, :scheme, :api_key, :debug
    attr_writer :timeout

    def initialize
      @scheme = 'https'
      @host = 'api.firecrawl.dev'
      @port = nil
    end

    def url
      uri.to_s
    end

    def uri
      @uri ||= URI::Generic.build(
        scheme: @scheme,
        host: @host,
        port: @port
      )
    end

    def url=(url)
      uri = URI.parse(url)
      @scheme = uri.scheme
      @host = uri.host
      @port = uri.port
      @uri = uri
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
