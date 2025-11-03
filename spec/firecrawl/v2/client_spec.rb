# frozen_string_literal: true

require "spec_helper"

describe Firecrawl::V2::Client do
  subject { described_class.new }
  let(:test_page) { 'https://www.firecrawl.dev' }
  let(:test_pages) { ['https://www.firecrawl.dev', 'https://rubygems.org/'] }
   
  context 'Scrape Endpoint' do 
    it '[POST] /scrape', :vcr do
      result = subject.scrape(test_page)
      expect(result).to be_a(Firecrawl::V2::Scrape)
    end
  end

  context "Batch Scrape Endpoint", order: :defined do
    before(:context) do
      @batch_scrape = {}
    end
    
    it '[POST] /batch/scrape', :vcr do
      result = subject.batch_scrape(test_pages)
      expect(result).to be_a(Firecrawl::V2::BatchScrape)
      @batch_scrape[:id] = result.id
    end

    it '[GET] /batch/scrape/{:id}', :vcr do
      result = subject.batch_scrape_status(@batch_scrape[:id])
      expect(result).to be_a(Firecrawl::V2::BatchScrapeStatus)
      expect(result.data).to all(be_a(Firecrawl::V2::Document))
    end

    it '[DELETE] /batch/scrape/{:id}', :vcr do
      result = subject.cancel_batch_scrape(@batch_scrape[:id])
      expect(result).to be_a(Firecrawl::V2::CancelBatchScrape)
    end

    it '[GET] /batch/scrape/{:id}/errors', :vcr do
      result = subject.batch_scrape_errors(@batch_scrape[:id])
      expect(result).to be_a(Firecrawl::V2::BatchScrapeErrors)
    end
  end

  context "Crawl Endpoint", order: :defined do
    before(:context) do
      @crawl = {}
    end
    
    it '[POST] /crawl', :vcr do
      result = subject.crawl(test_page)
      expect(result).to be_a(Firecrawl::V2::Crawl)
      @crawl[:id] = result.id
    end

    it '[GET] /crawl/{:id}', :vcr do
      result = subject.crawl_status(@crawl[:id])
      expect(result).to be_a(Firecrawl::V2::CrawlStatus)
      expect(result.data).to all(be_a(Firecrawl::V2::Document))
    end

    it '[GET] /crawl/{:id}/errors', :vcr do
      result = subject.crawl_errors(@crawl[:id])
      expect(result).to be_a(Firecrawl::V2::CrawlErrors)
    end

    it '[GET] /crawl/active', :vcr do
      result = subject.active_crawls
      expect(result).to be_a(Firecrawl::V2::ActiveCrawls)
    end

    it '[DELETE] /crawl/{:id}', :vcr do
      result = subject.cancel_crawl(@crawl[:id])
      expect(result).to be_a(Firecrawl::V2::CancelCrawl)
    end
  end

  context "Map Endpoint", order: :defined do
    before(:context) do
      @map = {}
    end

    it '[POST] /map', :vcr do
      result = subject.map(test_page)
      expect(result).to be_a(Firecrawl::V2::Map)
    end
  end

  context "Search Endpoint", order: :defined do
    before(:context) do
      @search = {}
    end
    
    it '[POST] /search', :vcr do
      result = subject.search('firecrawlについて')
      expect(result).to be_a(Firecrawl::V2::Search)
    end
  end
    
  context "Extract Endpoint", order: :defined do
    before(:context) do
      @extract = {}
    end
    
    it '[POST] /extract', :vcr do
      result = subject.extract(test_pages)
      expect(result).to be_a(Firecrawl::V2::Extract)
      @extract[:id] = result.id
    end

    it '[GET] /extract/{:id}', :vcr do
      result = subject.extract_status(@extract[:id])
      expect(result).to be_a(Firecrawl::V2::ExtractStatus)
    end
  end

  context "Account Endpoint", order: :defined do
    before(:context) do
      @account = {}
    end

    it '[GET] /team/credit-usage', :vcr do
      result = subject.credit
      expect(result).to be_a(Firecrawl::V2::CreditUsage)
    end

    it '[GET] /team/credit-usage/historical', :vcr do
      result = subject.credit_historical
      expect(result).to be_a(Firecrawl::V2::CreditHistorical)
    end

    it '[GET] /team/token-usage', :vcr do
      result = subject.token
      expect(result).to be_a(Firecrawl::V2::TokenUsage)
    end

    it '[GET] /team/token-usage/historical', :vcr do
      result = subject.token_historical
      expect(result).to be_a(Firecrawl::V2::TokenHistorical)
    end

    it '[GET] /team/queue', :vcr do
      result = subject.queue
      expect(result).to be_a(Firecrawl::V2::QueueStatus)
    end
  end
end
