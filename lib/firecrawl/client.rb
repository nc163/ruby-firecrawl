# frozen_string_literal: true

require "firecrawl/http"

#
module Firecrawl
  class Client
    include Firecrawl::HTTP

    def initialize(uri_base = nil)
      self.uri_base = uri_base.nil? ? Firecrawl.configuration.uri 
                               : URI.parse(uri_base)
    end

    protected

    def uri_base=(uri)
      @uri_base = uri
    end

    def uri_base
      @uri_base
    end

    def uri(path: , parameters: nil)
      uri_base.merge(path).tap do |uri|
        uri.query = URI.encode_www_form(parameters) if parameters
      end
    end

    # エラーハンドリング
    def handle_error(response)
      raise Firecrawl::ErrorHandler.new(response.status, response.body)
    end
  end
end
