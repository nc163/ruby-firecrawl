# frozen_string_literal: true

module Firecrawl
  class ErrorHandler < Faraday::Middleware
    def call(env)
      @app.call(env).on_complete do |response_env|
        unless response_env.status == 200

          error_message = build_error_message(response_env)
          case response_env.status
          when 400 then raise Firecrawl::BadRequestError, error_message
          when 401 then raise Firecrawl::UnauthorizedError, error_message
          when 402 then raise Firecrawl::PaymentRequiredError, error_message
          when 408 then raise Firecrawl::RequestTimeoutError, error_message
          when 404 then raise Firecrawl::ResourceNotFound, error_message
          when 429 then raise Firecrawl::TooManyRequestsError, error_message
          when 500..599 then raise Firecrawl::ServerError, error_message
          else
            raise Faraday::ClientError, error_message
          end
        end
      end
    end

    private

    def build_error_message(response_env)
      body = response_env.body

      message = if body.is_a?(Hash)
        body['message'] || body['error']
      else
      body.to_s.presence
      end

      "#{message}"
    end
  end
end
