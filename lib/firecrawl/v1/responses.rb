# frozen_string_literal: true

require "ostruct"
require "firecrawl/responses"

module Firecrawl
  module V1
    include Firecrawl::Responses

    class Document < ::OpenStruct
      attr_reader :metadata

      def initialize(attributes = {})
        if metadata = attributes.delete(:metadata) || {}
          @metadata = Metadata.new(metadata) if metadata.is_a?(Hash)
        end
        super(attributes)
      end
    end

    class Metadata < ::OpenStruct
      def initialize(attributes = {})
        super(attributes)
      end
    end

    # Scrape Endpoints

    class ScrapeResponse < Response
      attr_reader :success
      attr_reader :data

      def initialize(response)
        @success = response['success']
        @data = Document.new(response['data']) if response.key?('data')
      end

      def to_h
        {
          success: @success,
          data: @data.to_h
        }
      end
    end


    class BatchScrapeResponse < Response
      attr_reader :success
      attr_reader :id
      attr_reader :url
      attr_reader :invalidURLs

      def initialize(response)
        @success = response['success']
        @id = response['id'] if response.key?('id')
        @url = response['url'] if response.key?('url')
        @invalidURLs = response['invalidURLs'] if response.key?('invalidURLs')
      end

      def to_h
        {
          success: @success,
          id: @id,
          url: @url,
          invalidURLs: @invalidURLs
        }
      end
    end

    class BatchScrapeStatusResponse < Response
      attr_reader :status
      attr_reader :total
      attr_reader :completed
      attr_reader :creditsUsed
      attr_reader :expiresAt
      attr_reader :next
      attr_reader :data

      def initialize(response)
        @status = response['status']
        @total = response['total'] if response.key?('total')
        @completed = response['completed'] if response.key?('completed')
        @creditsUsed = response['creditsUsed'] if response.key?('creditsUsed')
        @expiresAt = response['expiresAt'] if response.key?('expiresAt')
        @next = response['next'] if response.key?('next')

        if response.key?('data') && response['data'].is_a?(Array)
          @data = response['data'].map { |doc| Document.new(doc) }
        end
      end

      def to_h
        {
          status: @status,
          total: @total,
          completed: @completed,
          creditsUsed: @creditsUsed,
          expiresAt: @expiresAt,
          next: @next,
          data: @data
        }
      end
    end

    #
    #
    #

    class CancelBatchScrape < Response 
      attr_reader :success
      attr_reader :message

      def initialize(response)
        @success = response['success']
        @message = response['message'] if response.key?('message')
      end

      def to_h
        {
          success: @success,
          message: @message
        }
      end
    end

    class BatchScrapeErrors < Response 
      attr_reader :success
      attr_reader :message 
      
      def initialize(response)
        @success = response['success']
        @message = response['message'] if response.key?('message')
      end

      def to_h
        {
          success: @success,
          message: @message
        }
      end
    end

    # Crawl Endpoints

    class CrawlResponse < Response
      attr_reader :success
      attr_reader :id
      attr_reader :url

      def initialize(response)
        @success = response['success']
        @id = response['id'] if response.key?('id')
        @url = response['url'] if response.key?('url')
      end

      def to_h
        {
          success: @success,
          id: @id,
          url: @url,
        }
      end
    end

    class CrawlStatusResponse < Response
      attr_reader :success
      attr_reader :status
      attr_reader :total
      attr_reader :completed
      attr_reader :creditsUsed
      attr_reader :expiresAt
      attr_reader :next
      attr_reader :data

      def initialize(response)
        @success = response['success']
        @status = response['status']
        @total = response['total'] if response.key?('total')
        @completed = response['completed'] if response.key?('completed')
        @creditsUsed = response['creditsUsed'] if response.key?('creditsUsed')
        @expiresAt = response['expiresAt'] if response.key?('expiresAt')
        @next = response['next'] if response.key?('next')

        if response.key?('data') && response['data'].is_a?(Array)
          @data = response['data'].map { |doc| Document.new(doc) }
        end
      end

      def to_h
        {
          status: @status,
          total: @total,
          completed: @completed,
          creditsUsed: @creditsUsed,
          expiresAt: @expiresAt,
          next: @next,
          data: @data
        }
      end
    end

    class CancelCrawlResponse < Response
      attr_reader :status

      def initialize(response)
        @status = response['status']
      end

      def to_h
        {
          status: @status
        }
      end
    end

    class CrawlErrorsResponse < Response
      attr_reader :errors
      attr_reader :robotsBlocked

      def initialize(response)
        @errors = response['errors']
        @robotsBlocked = response['robotsBlocked']
      end

      def to_h
        {
          errors: @errors,
          robotsBlocked: @robotsBlocked
        }
      end
    end

    class ActiveCrawlsResponse < Response
      attr_reader :status

      def initialize(response)
      end

      def to_h
        {
          status: @status
        }
      end
    end

    # Map Endpoints

    class MapResponse < Response
      attr_reader :success
      attr_reader :links

      def initialize(response)
        @success = response['success']
        @links = response['links'] if response.key?('links')
      end

      def to_h
        {
          status: @status,
          links: @links
        }
      end
    end

    # Search Endpoints

    class SearchResponse < Response
      attr_reader :success
      attr_reader :data
      attr_reader :warning

      def initialize(response)
        @success = response['success']
        if response.key?('data') && response['data'].is_a?(Array)
          @data = response['data'].map { |doc| Document.new(doc) }
        end
        @warning = response['warning'] if response.key?('warning')
      end

      def to_h
        {
          status: @status,
          data: @data,
          warning: @warning
        }
      end
    end

    # Extract Endpoints

    class ExtractResponse < Response
      attr_reader :success
      attr_reader :id
      attr_reader :invalidURLs

      def initialize(response)
        @success = response['success']
        @id = response['id'] if response.key?('id')
        @invalidURLs = response['invalidURLs'] if response.key?('invalidURLs')
      end

      def to_h
        {
          success: @success,
          id: @id,
          invalidURLs: @invalidURLs
        }
      end
    end

    class ExtractStatusResponse < Response
      attr_reader :success
      attr_reader :data
      attr_reader :status
      attr_reader :expiresAt

      def initialize(response)
        @success = response['success']
        @data = OpenStruct.new(response['data']) if response.key?('data')
        @status = response['status'] if response.key?('status')
        @expiresAt = response['expiresAt'] if response.key?('expiresAt')
      end

      def to_h
        {
          success: @success,
          data: @data,
          status: @status,
          expiresAt: @expiresAt
        }
      end
    end

    # Account Endpoints

    class CreditUseResponse < Response
      attr_reader :success
      attr_reader :data

      def initialize(response)
        @success = response['success'] if response.key?('success')
        @data = OpenStruct.new(response['data']) if response.key?('data')
      end

      def to_h
        {
          success: @success,
          data: @data
        }
      end
    end

    class TokenUsageResponse < Response
      attr_reader :success
      attr_reader :data

      def initialize(response)
        @success = response['success'] if response.key?('success')
        @data = OpenStruct.new(response['data']) if response.key?('data')
      end

      def to_h
        {
          success: @success,
          data: @data
        }
      end
    end

  end
end