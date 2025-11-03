# frozen_string_literal: true

module Firecrawl
  module V2
     
    Document = Struct.new(
      :markdown,
      :html,
      :rawHtml,
      :screenshot,
      :links,
      :metadata,
      keyword_init: true
    )

    Scrape = Struct.new(
      *Document.members,
      :summary,
      :actions,
      :llm_extraction,
      :warning,
      :changeTracking,
      keyword_init: true
    )

    BatchScrape = Struct.new(
      :success,
      :id,
      :url,
      :invalidURLs, 
      keyword_init: true
    )

    BatchScrapeStatus = Struct.new(
      :success,
      :status,
      :total,
      :completed,
      :creditsUsed,
      :expiresAt,
      :next,
      :data, # => Array[Document]
      keyword_init: true
    ) do
      def initialize(**args)
        if args[:data].is_a?(Array)
          args[:data] = args[:data].map { |doc| Document.new(**doc) }
        end
        super(**args)
      end
    end

    CancelBatchScrape = Struct.new(
      :success,
      :status,
      :message,
      keyword_init: true
    )

    BatchScrapeErrors = Struct.new(
      :errors,
      :robotsBlocked,
      keyword_init: true
    )

    # Crawl Endpoints
    
    Crawl = Struct.new(
      :success,
      :id,
      :url,
      keyword_init: true
    )

    CrawlStatus = Struct.new(
      :success,
      :status,
      :total,
      :completed,
      :creditsUsed,
      :expiresAt,
      :next,
      :data, # => Array[Document]
      keyword_init: true
    ) do
      def initialize(**args)
        if args[:data].is_a?(Array)
          args[:data] = args[:data].map { |doc| Document.new(**doc) }
        end
        super(**args)
      end
    end

    CancelCrawl = Struct.new(
      :status,
      keyword_init: true
    )

    CrawlErrors = Struct.new(
      :errors,
      :robotsBlocked,
      keyword_init: true
    )

    ActiveCrawls = Struct.new(
      :success,
      :crawls,
      keyword_init: true
    )

    # Map Endpoints
     
    Map = Struct.new(
      :success,
      :links,
      keyword_init: true
    )

    # Search Endpoints
    
    Search = Struct.new(
      :success,
      :data,
      :warning,
      :creditsUsed,
      keyword_init: true
    )

    # Extract Endpoints
     
    Extract = Struct.new(
      :success,
      :id,
      :urlTrace,
      :invalidURLs,
      keyword_init: true
    )

    ExtractStatus = Struct.new(
      :success,
      :data,
      :status,
      keyword_init: true
    )

    # Account Endpoints
     
    CreditUsage = Struct.new(
      :success,
      :data,
      keyword_init: true
    )

    CreditHistorical = Struct.new(
      :success,
      :periods,
      keyword_init: true
    )

    TokenUsage = Struct.new(
      :success,
      :data,
      keyword_init: true
    )

    TokenHistorical = Struct.new(
      :success,
      :periods,
      keyword_init: true
    )

    QueueStatus = Struct.new(
      :success,
      :jobsInQueue,
      :activeJobsInQueue,
      :waitingJobsInQueue,
      :maxConcurrency,
      :mostRecentSuccess,
      keyword_init: true
    )
  end
end