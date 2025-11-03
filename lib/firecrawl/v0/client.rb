# frozen_string_literal: true

require "firecrawl/client"
require_relative "api_version"
require_relative "responses"

module Firecrawl
  module V0
    class Client < Firecrawl::Client

      # Scrape Endpoints

      # POST /v0/scrape
      # @param url [String] URL to scrape.
      # @param options [Hash] Options to pass to the scrape endpoint. https://docs.firecrawl.dev/api-reference/endpoint/scrape
      # @return [Firecrawl::V0::Scrape]
      def scrape(url, options = {})
        options[:url] = url
        options[:timeout] ||= 300000
        response = post to("scrape"), body: options
        Scrape.new(**response.body['data'])
      end

      # Crawl Endpoints

      # POST /v0/crawl
      # @param url [String] The base URL to start crawling from.
      # @param options [Hash] Options to pass to the crawl endpoint. https://docs.firecrawl.dev/api-reference/endpoint/crawl-post
      # @return [Firecrawl::V0::Crawl]
      def crawl(url, options = {})
        options[:url] = url
        response = post to("crawl"), body: options
        Crawl.new(**response.body)
      end

      # GET /v0/crawl/{:id}
      # @param job_id [String] The ID of the crawl job.
      # @return [Firecrawl::V0::CrawlStatus]
      def crawl_status(job_id)
        response = get to("crawl/#{job_id}")
        CrawlStatus.new(**response.body)
      end
      

      # DELETE /v0/crawl/{:id}
      # @param job_id [String] The ID of the crawl job.
      # @return [Firecrawl::V0::CancelCrawl]
      def cancel_crawl(job_id)
        response = delete to("crawl/#{job_id}")
        CancelCrawl.new(response.body)
      end

      private 

      def to(path)
        url(API_VERSION, path)
      end
    end
  end
end
