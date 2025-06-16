# frozen_string_literal: true

module Firecrawl
  module HTTPHeaders

    def default_headers
      @default_headers ||= {}
      @default_headers['Content-Type'] = 'application/json; charset=utf-8'
      @default_headers['Accept'] = 'application/json'
      @default_headers['Authorization'] = "Bearer #{Firecrawl.configuration.api_key}" if Firecrawl.configuration.api_key
      @default_headers
    end

  end
end