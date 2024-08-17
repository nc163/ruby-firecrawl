# frozen_string_literal: true

#
module Firecrawl
  #
  module API
    #
    module V0
      #
      class Client < ::Firecrawl::Client

        def initialize(url: nil, debug: false)
          super(api_key: nil, url: url, debug: debug)
        end

        # GET /status
        # https://docs.firecrawl.dev/api-reference/endpoint/scrape
        def crawl_status(job_id)
          self.get(path: "/crawl/status/#{job_id}")
        end

        # DELETE /cancel
        # https://docs.firecrawl.dev/api-reference/endpoint/crawl-cancel
        def crawl_cancel(job_id)
          self.delete(path: "/crawl/cancel/#{job_id}")
        end

        # POST /scrape
        # https://docs.firecrawl.dev/api-reference/endpoint/scrape
        #
        # @param url [String] URL to scrape
        # @param page_options [Hash] Page options
        # @param extractor_options [Hash] Extractor options
        # @param timeout [Integer] Timeout in milliseconds for the request
        def scrape(url, page_options: {}, extractor_options: {}, timeout: 30000)
          parameters = { url: url, timeout: timeout }
          parameters[:pageOptions] = page_options
          parameters[:extractorOptions] = extractor_options

          self.post(path: "/scrape", parameters: parameters)
        end

        # @param screenshot [Boolean] Include a screenshot of the top of the page that you are scraping.
        # @param include_html [Boolean] Include the HTML version of the content on page. Will output a html key in the response.
        # @param include_raw_html [Boolean] Include the raw HTML content of the page. Will output a rawHtml key in the response.
        # @param only_include_tags [Array] Only include tags, classes and ids from the page in the final output. Use comma separated values. Example: 'script, .ad, #footer'
        # @param waitFor [Integer] Wait x amount of milliseconds for the page to load to fetch content
        def scrape_page_options(include_html: false, wait_for: 0)
          options = {}
          options['includeHtml'] = include_html
          options['waitFor'] = wait_for
          options
        end

        # @page mode ['markdown'|'llm-extraction'|llm-extraction-from-raw-html'|'llm-extraction-from-markdown'] The extraction mode to use. 'markdown': Returns the scraped markdown content, does not perform LLM extraction. 'llm-extraction': Extracts information from the cleaned and parsed content using LLM. 'llm-extraction-from-raw-html': Extracts information directly from the raw HTML using LLM. 'llm-extraction-from-markdown': Extracts information from the markdown content using LLM.
        # @param extraction_prompt [String] A prompt describing what information to extract from the page, applicable for LLM extraction modes.
        # @param extraction_schema [Hash] The schema for the data to be extracted, required only for LLM extraction modes.
        def scrape_extractor_options(mode: "markdown", extraction_prompt: '', extraction_schema: {})
          options = {}
          if 'markdown'.is_a? String
            if !['markdown', 'llm-extraction', 'llm-extraction-from-raw-html', 'llm-extraction-from-markdown'].include?(mode)
              raise "Invalid mode" 
            end
          end
          options['mode'] = mode
          options['extractionPrompt'] = extraction_prompt
          options['extractionSchema'] = extraction_schema
          options
        end

        # POST /crawl
        # https://docs.firecrawl.dev/api-reference/endpoint/crawl
        def crawl(url, crawler_options: {}, page_options: {})
          parameters = {
            url: url,
            # crawlerOtions: crawl_crawler_options,
            # pageOptions: crawl_page_options
          }
          self.post(path: "/crawl", parameters: parameters)
        end

        def crawl_crawler_options(only_main_content: true, include_html: true, screenshot: true, wait_for: 123, remove_tags: [], headers: {})
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

        # @param headers [Object] Headers to send with the request. Can be used to send cookies, user-agent, etc.
        # @param include_html [Boolean] Include the HTML version of the content on page.
        # @param include_raw_html [Boolean] Include the raw HTML content of the page. Will output a rawHtml key in the response.
        def crawl_page_options(headers: {}, include_html: false, include_raw_html: false)
          options = {}
          options['headers'] = headers
          options['includeHtml'] = include_html
          options['includeRawHtml'] = include_raw_html
          options
        end

        protected

        def api_version
          'v0'
        end
        
      end
    end
  end
end
