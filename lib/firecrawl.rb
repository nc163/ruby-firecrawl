# frozen_string_literal: true

require 'faraday'
require "firecrawl/v0/client"
require "firecrawl/v1/client"
require "firecrawl/v2/client"
require "firecrawl/version"

#
module Firecrawl
  class Error < StandardError; end
  class InternalError < Error; end
  class ConfigurationError < Error; end
  class AuthenticationError < Error; end

  # HTTP 400 The request was malformed or contained invalid parameters.
  class BadRequestError < Faraday::BadRequestError; end      
  
  # HTTP 401 The API key was not provided.
  class UnauthorizedError < Faraday::UnauthorizedError; end

  # HTTP 402 Payment required
  class PaymentRequiredError < Faraday::ClientError; end
  
  # HTTP 404 The requested resource could not be located.
  class ResourceNotFound < Faraday::ResourceNotFound; end
  
  # HTTP 429 The rate limit has been surpassed.
  class TooManyRequestsError < Faraday::TooManyRequestsError; end
  
  # HTTP 5xx Signifies a server error with Firecrawl.
  class ServerError < Faraday::ServerError; end

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
