#
module Firecrawl::API
  #
  module V0

    API_VERSION = 'v0'.freeze

    # GET /status
    # https://docs.firecrawl.dev/api-reference/endpoint/scrape
    def self.status(job_id)
      ::Firecrawl::Client.get(api_version: API_VERSION, path: "/status/#{job_id}")
    end

    # DELETE /cancel
    # https://docs.firecrawl.dev/api-reference/endpoint/crawl-cancel
    def self.cancel(job_id)
      ::Firecrawl::Client.get(api_version: API_VERSION, path: "/cancel/#{job_id}")
    end

    # POST /scrape
    # https://docs.firecrawl.dev/api-reference/endpoint/scrape
    #
    # @param url [String] URL to scrape
    # @param page_options [Hash] Page options
    # @param extractor_options [Hash] Extractor options
    # @param timeout [Integer] Timeout in milliseconds for the request
    def self.scrape(url, page_options: scrape_page_options, extractor_options: scrape_extractor_options, timeout: 30000)
      parameters = {
        url: url,
        # pageOptions: page_options,
        # extractorOptions: extractor_options,
        timeout: timeout
      }
      ::Firecrawl::Client.post(api_version: API_VERSION, path: "/scrape", parameters: parameters)
    end

    def self.scrape_page_options(only_main_content: true, include_html: true, screenshot: true, wait_for: 123, remove_tags: [], headers: {}, replace_all_paths_with_absolute_paths: false)
      {
        "onlyMainContent" => only_main_content,
        "includeHtml" => include_html,
        "screenshot" => screenshot,
        "waitFor" => wait_for,
        "removeTags" => remove_tags,
        "headers" => headers,
        "replaceAllPathsWithAbsolutePaths" => replace_all_paths_with_absolute_paths
      }
    end

    def self.scrape_extractor_options(mode: "llm-extraction", extraction_prompt: "<string>", extraction_schema: {})
      {
        "mode" => mode,
        "extractionPrompt" => extraction_prompt,
        "extractionSchema" => extraction_schema
      }
    end

    # POST /crawl
    # https://docs.firecrawl.dev/api-reference/endpoint/crawl
    def self.crawl(url, crawler_options: crawl_crawler_options, page_options: crawl_page_options)
      parameters = {
        url: url,
        crawlerOtions: crawl_crawler_options,
        pageOptions: crawl_page_options
      }
      ::Firecrawl::Client.post(api_version: API_VERSION, path: "/crawl", parameters: parameters)
    end

    def self.crawl_crawler_options(only_main_content: true, include_html: true, screenshot: true, wait_for: 123, remove_tags: [], headers: {})
      {
        "includes" => [],
        "excludes" => [],
        "generateImgAltText" => true,
        "returnOnlyUrls" => true,
        "maxDepth" => 123,
        "mode" => "default",
        "ignoreSitemap" => true,
        "limit" => 123,
        "allowBackwardCrawling" => true
      }
    end

    def self.crawl_page_options(only_main_content: true, include_html: true, screenshot: true, wait_for: 123, remove_tags: [], headers: {}, replace_all_paths_with_absolute_paths: true)
      {
        "onlyMainContent" => only_main_content,
        "includeHtml" => include_html,
        "screenshot" => screenshot,
        "headers" => headers,
        "removeTags" => remove_tags,
        "replaceAllPathsWithAbsolutePaths" => replace_all_paths_with_absolute_paths
      }
    end

  end
end
