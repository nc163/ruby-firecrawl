# frozen_string_literal: true

require 'faraday'

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

  # HTTP 408 The requested resource could not be located.
  class RequestTimeoutError < Faraday::TimeoutError; end

  # HTTP 429 The rate limit has been surpassed.
  class TooManyRequestsError < Faraday::TooManyRequestsError; end

  # HTTP 5xx Signifies a server error with Firecrawl.
  class ServerError < Faraday::ServerError; end
end
