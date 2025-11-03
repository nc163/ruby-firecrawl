# frozen_string_literal: true

require "firecrawl/client"
require_relative "api_version"
require_relative "responses"

module Firecrawl
  module V2
    class Client < Firecrawl::Client

      # Scrape Endpoints

      # POST /v2/scrape
      # @param url [String] URL to scrape.
      # @param options [Hash] Options to pass to the scrape endpoint. https://docs.firecrawl.dev/api-reference/endpoint/scrape
      # @return [Firecrawl::V1::Scrape] 
      def scrape(url, options = {})
        options[:url] = url
        options[:timeout] ||= 300000
        response = post to("scrape"), body: options
        Scrape.new(**response.body['data'])
      end

      # POST /v2/batch/scrape
      # @param urls [Array<String>] Array of URLs to scrape.
      # @param options [Hash] Options to pass to the scrape endpoint. https://docs.firecrawl.dev/api-reference/endpoint/batch-scrape
      # @return [Firecrawl::V1::BatchScrape]
      def batch_scrape(urls, options = {})
        options[:urls] = urls
        response = post to("batch/scrape"), body: options
        BatchScrape.new(**response.body)
      end


      # GET /v2/batch/scrape/#{:id}
      # @param id [String] The ID of the batch scrape job.
      # @return [Firecrawl::V1::BatchScrapeStatus] The status of the batch scrape job.
      def batch_scrape_status(id)
        response = get to("batch/scrape/#{id}")
        BatchScrapeStatus.new(**response.body)
      end

      # DELETE /v2/batch/scrape/{:id}
      # @param id [String] The ID of the batch scrape job to cancel.
      # @return [Firecrawl::V1::CancelBatchScrape]
      def cancel_batch_scrape(id)
        response = delete to("batch/scrape/#{id}")
        CancelBatchScrape.new(**response.body)
      end

      # GET /v2/batch/scrape/{:id}/errors
      # @param id [String] The ID of the batch scrape job to get errors for.
      # @return [Firecrawl::V1::BatchScrapeErrors] The errors from the batch scrape job.
      def batch_scrape_errors(id)
        response = get to("batch/scrape/#{id}/errors")
        BatchScrapeErrors.new(**response.body)
      end

      # Crawl Endpoints

      # POST /v2/crawl
      # @param url [String] The base URL to start crawling from.
      # @param options [Hash] Options to pass to the crawl endpoint. https://docs.firecrawl.dev/api-reference/endpoint/crawl-post
      # @return [Firecrawl::V1::Crawl] The crawl job information.
      def crawl(url, options = {})
        options[:url] = url
        response = post to("crawl"), body: options
        Crawl.new(**response.body)
      end

      # GET /v2/crawl/{:id}
      # @param job_id [String] The ID of the crawl job.
      # @return [Firecrawl::V1::CrawlStatus] The status of the crawl job.
      def crawl_status(job_id)
        response = get to("crawl/#{job_id}")
        CrawlStatus.new(**response.body)
      end
      
      # DELETE /v2/crawl/{:id}
      # @param job_id [String] The ID of the crawl job.
      # @return [Firecrawl::V1::CancelCrawl] The cancellation result.
      def cancel_crawl(job_id)
        response = delete to("crawl/#{job_id}")
        CancelCrawl.new(response.body)
      end

      # GET /v2/crawl/{:id}/errors
      # @param job_id [String] The ID of the crawl job to get errors for.
      # @return [Firecrawl::V1::CrawlErrors] The errors from the crawl job.
      def crawl_errors(job_id)
        response = get to("crawl/#{job_id}/errors")
        CrawlErrors.new(response.body)
      end

      # GET /v2/crawl/active
      # @return [Firecrawl::V1::ActiveCrawls] The active crawls status.
      def active_crawls
        response = get to("crawl/active")
        ActiveCrawls.new(**response.body)
      end

      # Map Endpoints

      # POST /v2/map
      # @param url [String] The base URL to start crawling from
      # @param options [Hash] Options to pass to the map endpoint. https://docs.firecrawl.dev/api-reference/endpoint/map
      # @return [Firecrawl::V1::Map] The mapped links from the website.
      def map(url, options = {})
        options[:url] = url
        response = post to("map"), body: options
        Map.new(response.body)
      end

      # Search Endpoints

      # POST /v2/search
      # @param query [String] The search query to perform.
      # @param options [Hash] Options to pass to the search endpoint. https://docs.firecrawl.dev/api-reference/endpoint/search
      # @return [Firecrawl::V1::Search] The search results.
      def search(query, options = {})
        options[:query] = query
        response = post to("search"), body: options
        Search.new(response.body)
      end

      # Extract Endpoints

      # POST /v2/extract
      # @param urls [Array<String>] Array of URLs to extract data from.
      # @param options [Hash] Options to pass to the extract endpoint. https://docs.firecrawl.dev/api-reference/endpoint/extract
      # @return [Firecrawl::V1::Extract] The extraction job information.
      def extract(urls, options = {})
        options[:urls] = urls
        response = post to("extract"), body: options
        Extract.new(response.body)
      end
      
      # GET /v2/extract/{:id}
      # @param id [String] The ID of the extract job.
      # @return [Firecrawl::V1::ExtractStatus] The status of the extract job.
      def extract_status(id)
        response = get to("extract/#{id}")
        ExtractStatus.new(response.body)
      end

      # Account Endpoints

      # GET /v2/team/credit-usage
      # @return [Faraday::Response] The current credit usage information.
      def credit
        response = get to("team/credit-usage")
        CreditUsage.new(**response.body)
      end

      # GET /v2/team/credit-usage/historical
      # @return [Faraday::Response] The historical credit usage information.
      def credit_historical
        response = get to("team/credit-usage/historical")
        CreditHistorical.new(**response.body)
      end

      # GET /v2/team/token-usage
      # @return [Faraday::Response] The current token usage information.
      def token
        response = get to("team/token-usage")
        TokenUsage.new(**response.body)
      end

      # GET /v2/team/token-usage/historical
      # @return [Faraday::Response] The historical token usage information.
      def token_historical
        response = get to("team/token-usage/historical")
        TokenHistorical.new(**response.body)
      end

      # GET /v2/team/queue-status
      # @return [Faraday::Response] The current queue status information.
      def queue
        response = get to("team/queue-status")
        QueueStatus.new(**response.body)
      end

      private 

      def to(path)
        url(API_VERSION, path)
      end
    end
  end
end
