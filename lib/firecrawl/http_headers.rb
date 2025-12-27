# frozen_string_literal: true

module Firecrawl
  module HTTPHeaders

    def default_headers
      @default_headers ||= begin
        headers = {}
        headers['Content-Type'] = 'application/json; charset=utf-8'
        headers['Accept'] = 'application/json'
        headers['Authorization'] = "Bearer #{Firecrawl.configuration.api_key}" if Firecrawl.configuration.api_key
        headers.freeze
      end
    end
  end
end
