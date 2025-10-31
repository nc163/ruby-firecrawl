# frozen_string_literal: true

require "firecrawl/v0/client"
require "firecrawl/v1/client"
# require "firecrawl/v2/client"
require "firecrawl/version"

#
module Firecrawl
  class Error < StandardError; end
  class ConfigurationError < Error; end
  class AuthenticationError < Error; end

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
