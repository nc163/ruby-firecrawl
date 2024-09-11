# frozen_string_literal: true

#
module Firecrawl
  #
  module API
    #
    module V1
      #
      class Client < ::Firecrawl::Client


        def initialize(url: nil, debug: false)
          super(api_key: nil, url: url, debug: debug)
        end


        # POST /v1/scrape
        # https://docs.firecrawl.dev/api-reference/endpoint/scrape
        #
        # @param url [String] URL to scrape.
        # @param formats [Array<String>] Formats to include in the output. Available options: `markdown`, `html`, `rawHtml`, `links`, `screenshot`, `extract`, `screenshot@fullPage`
        # @param only_main_content [Boolean] Only return the main content of the page excluding headers, navs, footers, etc.
        # @param include_tags [Array<String>] Tags to include in the output.
        # @param exclude_tags [Array<String>] Tags to exclude from the output.
        # @param headers [Object] Headers to send with the request. Can be used to send cookies, user-agent, etc.
        # @param wait_for [Integer] Specify a delay in milliseconds before fetching the content, allowing the page sufficient time to load.
        # @param timeout [Integer] Timeout in milliseconds for the request.
        # @param extract [Hash] Extract object.
        def scrape(url, formats: ['markdown'], only_main_content: true, include_tags: [], exclude_tags: [], headers: {}, wait_for: 1000, timeout: 30000, extract: nil)
          parameters = {
            url: url,
            formats: formats,
            onlyMainContent: only_main_content,
            includeTags: include_tags,
            excludeTags: exclude_tags,
            headers: headers,
            waitFor: wait_for,
            timeout: timeout
          }
          parameters[:extract] = extract if !!extract
          self.post(path: "/scrape", parameters: parameters)
        end


        # POST /v1/crawl
        # https://docs.firecrawl.dev/api-reference/endpoint/crawl
        #
        # @param url [String] The base URL to start crawling from.
        # @param include_paths [Array<String>] URL patterns to include.
        # @param exclude_paths [Array<String>] URL patterns to exclude.
        # @param max_depth [Integer] Maximum depth to crawl relative to the entered URL.
        # @param ignore_sitemap [Boolean] Ignore the website sitemap when crawling.
        # @param limit [Integer] Maximum number of pages to crawl.
        # @param allow_backward_links [Boolean] Enables the crawler to navigate from a specific URL to previously linked pages.
        # @param allow_external_links [Boolean] Allows the crawler to follow links to external websites.
        # @param webhook [String] The URL to send the webhook to. This will trigger for crawl started (crawl.started) ,every page crawled (crawl.page) and when the crawl is completed (crawl.completed or crawl.failed). The response will be the same as the /scrape endpoint.
        # @param scrape_options [Hash] Options to pass to the scrape endpoint.
        def crawl(url, include_paths: [], exclude_paths: [], max_depth: 2, ignore_sitemap: true, limit: 10, allow_backward_links: false, allow_external_links: false, webhook: nil, scrape_options: {})
          parameters = {
            url: url,
            includePaths: include_paths,
            excludePaths: exclude_paths,
            maxDepth: max_depth,
            ignoreSitemap: ignore_sitemap,
            limit: limit,
            allowBackwardLinks: allow_backward_links,
            allowExternalLinks: allow_external_links,
            scrapeOptions: scrape_options
          }
          parameters[:webhook] = webhook if !!webhook
          self.post(path: "/crawl", parameters: parameters)
        end


        # GET /v1/crawl/:id
        # https://docs.firecrawl.dev/api-reference/endpoint/scrape
        #
        # @param job_id [String] The ID of the crawl job.
        def get_crawl_status(job_id)
          self.get(path: "/crawl/#{job_id}")
        end
        

        # DELETE /v1/crawl/:id
        # https://docs.firecrawl.dev/api-reference/endpoint/crawl-cancel
        #
        # @param job_id [String] The ID of the crawl job.
        def cancel_crawl(job_id)
          self.delete(path: "/crawl/#{job_id}")
        end


        # POST /v1/map
        # https://docs.firecrawl.dev/api-reference/endpoint/map
        #
        # @param url [String] The base URL to start crawling from.
        # @param search [String] Search query to use for mapping. During the Alpha phase, the 'smart' part of the search functionality is limited to 100 search results. However, if map finds more results, there is no limit applied.
        # @param ignore_sitemap [Boolean] Ignore the website sitemap when crawling.
        # @param include_subdomains [Boolean] Include subdomains of the website.
        # @param limit [Integer] Maximum number of links to return.
        def map(url, search, ignore_sitemap: true, include_subdomains: false, limit: 5000)
          parameters = {
            query: query,
            search: search,
            ignoreSitemap: ignore_sitemap,
            includeSubdomains: include_subdomains,
            limit: limit
          }
          parameters[:pageOptions] = page_options
          parameters[:searchOptions] = search_options
          self.post(path: "/map", parameters: parameters)
        end


        protected


        def api_version
          'v1'
        end


      end
    end
  end
end
