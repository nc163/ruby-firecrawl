# frozen_string_literal: true

require "firecrawl/client"
require "firecrawl/v1/responses"

module Firecrawl
  module V1
    class Client < Firecrawl::Client

      # Scrape Endpoints

      # POST /v1/scrape
      # @param url [String] URL to scrape.
      # @param options [Hash] Options to pass to the scrape endpoint. https://docs.firecrawl.dev/api-reference/endpoint/scrape
      def scrape(url, options = {})
        options[:url] = url
        options[:timeout] ||= 300000
        response = post uri(path: "/v1/scrape"), body: options
        if response.success?
          ScrapeResponse.new(response.body)
        else
          handle_error(response)
        end
      end

      # POST /v1/batch/scrape
      # @param urls [Array<String>] Array of URLs to scrape.
      # @param options [Hash] Options to pass to the scrape endpoint. https://docs.firecrawl.dev/api-reference/endpoint/batch-scrape
      def batch_scrape(urls, options = {})
        options[:urls] = urls
        response = post uri(path: "/v1/batch/scrape"), body: options
        if response.success?
          BatchScrapeResponse.new(response.body)
        else
          handle_error(response)
        end
      end


      # GET /v1/batch/scrape/#{:id}
      # @param id [String] The ID of the batch scrape job.
      def batch_scrape_status(id)
        response = get uri(path: "/v1/batch/scrape/#{id}")
        if response.success?
          BatchScrapeStatusResponse.new(response.body)
        else
          handle_error(response)
        end
      end

      # DELETE /v1/batch/scrape/{:id}
      # @param id [String] The ID of the batch scrape job to cancel.
      def cancel_batch_scrape(id)
        response = delete uri(path: "/v1/batch/scrape/#{id}")
        if response.success?
          CancelBatchScrape.new(response.body)
        else
          handle_error(response)
        end
      end

      # GET /v1/batch/scrape/{:id}/errors
      # @param id [String] The ID of the batch scrape job to get errors for.
      def batch_scrape_errors(id)
        response = get uri(path: "/v1/batch/scrape/#{id}/errors")
        if response.success?
          BatchScrapeErrors.new(response.body)
        else
          handle_error(response)
        end
      end

      # Crawl Endpoints

      # POST /v1/crawl
      # @param url [String] The base URL to start crawling from.
      # @param options [Hash] Options to pass to the crawl endpoint. https://docs.firecrawl.dev/api-reference/endpoint/crawl-post
      def crawl(url, options = {})
        options[:url] = url
        response = post uri(path: "/v1/crawl"), body: options
        if response.success?
          CrawlResponse.new(response.body)
        else
          handle_error(response)
        end
      end

      # GET /v1/crawl/{:id}
      # @param job_id [String] The ID of the crawl job.
      def crawl_status(job_id)
        response = get uri(path: "/v1/crawl/#{job_id}")
        if response.success?
          CrawlStatusResponse.new(response.body)
        else
          handle_error(response)
        end
      end
      

      # DELETE /v1/crawl/{:id}
      # @param job_id [String] The ID of the crawl job.
      def cancel_crawl(job_id)
        response = delete uri(path: "/v1/crawl/#{job_id}")
        if response.success?
          CancelCrawlResponse.new(response.body)
        else
          handle_error(response)
        end
      end

      # GET /v1/crawl/{:id}/errors
      # @params job_id [String] The ID of the crawl job to get errors for.
      def crawl_errors(job_id)
        response = get uri(path: "/v1/crawl/#{job_id}/errors")
        if response.success?
          CrawlErrorsResponse.new(response.body)
        else
          handle_error(response)
        end
      end

      # GET /v1/crawl/active
      def active_crawls
        response = get uri(path: "/v1/crawl/active")
        if response.success?
          ActiveCrawlsResponse.new(response.body)
        else
          handle_error(response)
        end
      end

      # Map Endpoints

      # POST /v1/map
      # @param url [String] The base URL to start crawling from
      # @param options [Hash] Options to pass to the map endpoint. https://docs.firecrawl.dev/api-reference/endpoint/map
      def map(url, options = {})
        options[:url] = url
        response = post uri(path: "/v1/map"), body: options
        if response.success?
          MapResponse.new(response.body)
        else
          handle_error(response)
        end
      end

      # Search Endpoints

      # POST /v1/search
      # @param query [String] The search query to perform.
      # @param options [Hash] Options to pass to the search endpoint. https://docs.firecrawl.dev/api-reference/endpoint/search
      def search(query, options = {})
        options[:query] = query
        response = post uri(path: "/v1/search"), body: options
        if response.success?
          SearchResponse.new(response.body)
        else
          handle_error(response)
        end
      end

      # Extract Endpoints

      # POST /v1/extract
      # @param urls [Array<String>] Array of URLs to extract data from.
      # @param options [Hash] Options to pass to the extract endpoint. https://docs.firecrawl.dev/api-reference/endpoint/extract
      def extract(urls, options = {})
        options[:urls] = urls
        response = post uri(path: "/v1/extract"), body: options
        if response.success?
          ExtractResponse.new(response.body)
        else
          handle_error(response)
        end
      end
      
      # POST /v1/extract
      # @param urls [Array<String>] Array of URLs to extract data from.
      # @param options [Hash] Options to pass to the extract endpoint. https://docs.firecrawl.dev/api-reference/endpoint/extract
      def extract_status(id)
        response = get uri(path: "/v1/extract/#{id}")
      end

    end
  end
end
