#
module Firecrawl

  HTTParty::Basement.default_options.update(debug_output: $stdout)

  #
  class Client
    def initialize(api_key: nil, url: nil)
      Firecrawl.configuration.api_key = api_key if api_key
      Firecrawl.configuration.url     = url if url
    end

    # # HTTP Helpers
    #
    def self.get(path:, api_version:)
      HTTParty.get(
        uri(path: path, api_version: api_version),
        headers: headers
      )
    end

    def self.post(path:, api_version:, parameters:)
      puts '====='
      puts uri(path: path, api_version: api_version)
      puts headers
      puts '====='

      HTTParty.post(
        uri(path: path, api_version: api_version),
        headers: headers,
        body: parameters&.to_json
      )
    end

    private_class_method def self.uri(path:, api_version:)
      return "#{Firecrawl.configuration.url}/#{api_version}#{path}" if Firecrawl.configuration.url.present?
      "https://api.firecrawl.dev/#{api_version}" + path
    end

    private_class_method def self.headers
      headers = { "Content-Type" => "application/json" }
      headers["Authorization"] = "Bearer #{Firecrawl.configuration.api_key}" if Firecrawl.configuration.api_key
      headers
    end
  end
end
