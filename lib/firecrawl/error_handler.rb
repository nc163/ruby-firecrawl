# frozen_string_literal: true

module Firecrawl
  class ErrorHandler < StandardError
    attr_reader :status, :body

    def initialize(status, body)
      @status = status
      @body = body
      super("Error: #{status} - #{body}")
    end
  end

  def self.handle(response)
    raise ErrorHandler.new(response.status, response.body) unless response.success?
  end
end