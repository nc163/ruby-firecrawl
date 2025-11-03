# frozen_string_literal: true

module Firecrawl
  module V0
     
    Document = Struct.new(
      :markdown,
      :content,
      :html,
      :metadata,
      :llm_extraction,
      :warning,
      keyword_init: true
    )

    # Scrape Endpoints

    class Scrape < Document; end

    BatchScrape = Struct.new(
      :success,
      :id,
      :url,
      :invalidURLs, 
      keyword_init: true
    )

    # Crawl Endpoints
    
    Crawl = Struct.new(
      :jobId,
      keyword_init: true
    )

    CrawlStatus = Struct.new(
      :status,
      :current,
      :total,
      :data, # => Array[Document]
      :partial_data,
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
  end
end