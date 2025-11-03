# frozen_string_literal: true

require 'faraday'
require 'json'
require_relative 'http_headers'
require_relative 'error_handler'

module Firecrawl
  module HTTP
    include HTTPHeaders
  
    def get(uri)
      connection.get(uri)
    end

    def post(uri, body: nil)
      connection.post(uri) do |req|
        req.body = body.to_json if body
      end
    end

    def delete(uri)
      connection.delete(uri)
    end

    private

    def connection
      @faraday ||= Faraday.new do |b|
        default_headers.each do |key, value|
          b.headers[key] = value
        end
        b.options[:open_timeout] = 2
        b.options[:timeout] = 60
        b.use ErrorHandler
        b.use MiddlewareErrors if @log_errors
        b.response :json
      end
    end

  end
end