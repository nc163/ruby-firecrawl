# frozen_string_literal: true

#
module Firecrawl
  #
  class Client

    #
    def initialize(api_key: nil, url: nil, debug: false)
      Firecrawl.configuration.api_key = api_key if api_key
      Firecrawl.configuration.url = url if url
      HTTParty::Basement.default_options.update(debug_output: $stdout) if debug
    end

    # HTTP Helpers
    def get(path:)
      HTTParty.get(
        uri(path: path),
        headers: headers
      )
    end

    #
    def post(path:, parameters: {})
      HTTParty.post(
        uri(path: path),
        headers: headers,
        body: parameters&.to_json
      )
    end

    #
    def delete(path:)
      HTTParty.delete(
        uri(path: path),
        headers: headers
      )
    end

    protected
    
    def api_version
      raise
    end

    private

    def uri(path:)
      "#{Firecrawl.configuration.url}/#{self.api_version}#{path}"
    end

    def headers
      headers = { "Content-Type" => "application/json; charset=utf-8" }
      headers["Authorization"] = "Bearer #{Firecrawl.configuration.api_key}" if Firecrawl.configuration.api_key
      headers
    end
  end
end
