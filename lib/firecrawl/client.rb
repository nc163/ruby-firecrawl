# frozen_string_literal: true

require "firecrawl/http"

#
module Firecrawl
  class Client
    include Firecrawl::HTTP

    def uri_base
      @uri_base
    end

    def initialize(uri_base = nil)
      @uri_base = uri_base || Firecrawl.configuration.url
    end

    protected

    def uri_base=(uri)
      @uri_base = uri
    end

    def url(version, path, parameters: nil)
      "#{uri_base}/v#{version}/#{path}"
    end
  end
end
