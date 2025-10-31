# frozen_string_literal: true

require "spec_helper"

describe Firecrawl::V1::Client do
  subject { described_class.new('http://host.docker.internal:3002') }
  let(:test_page) { 'https://www.firecrawl.dev' }
  let(:test_pages) { ['https://www.firecrawl.dev', 'https://rubygems.org/'] }
  let(:test_404) { ['https://httpstat.us/404'] }

  # Scrape Endpoint
  
  it '[POST] /scrape', :vcr do
    result = subject.scrape(test_page)
    expect(result.success).to be true
    expect(result.data).to be_a(Firecrawl::V1::Document)
    expect(result.data.metadata).to be_a(Firecrawl::V1::Metadata)
  end

  # Batch Scrape Endpoints
  
  context "Batch Scrape" do 
    it '[POST] /batch/scrape', :vcr do
      result = subject.batch_scrape(test_pages)
      expect(result.success).to be true
      expect(result.id).to be_a(String)
      # result.id
      # => "dabe2b5f-a235-426e-ab2f-a6aedf7c6ab4"
    end

    it '[GET] /batch/scrape/{:id}', :vcr do
      result = subject.batch_scrape_status('dabe2b5f-a235-426e-ab2f-a6aedf7c6ab4')
      expect(result).to be_a(Firecrawl::V1::BatchScrapeStatusResponse)
      expect(result.total).to eq test_pages.length
    end

    it '[DELETE] /batch/scrape/{:id}', :vcr do
      result = subject.cancel_batch_scrape('dabe2b5f-a235-426e-ab2f-a6aedf7c6ab4')
      expect(result).to be_a(Firecrawl::V1::CancelBatchScrape)
      expect(result.success).to be true
    end

    it '[GET] /batch/scrape/{:id}/errors', :vcr do
      result = subject.batch_scrape_errors('dabe2b5f-a235-426e-ab2f-a6aedf7c6ab4')
      expect(result).to be_a(Firecrawl::V1::BatchScrapeErrors)
      expect(result.success).to be true
    end
  end

  # Crawl Endpoints
  
  context "Crawl" do 
    it '[POST] /crawl', :vcr do
      result = subject.crawl(test_page)
      expect(result).to be_a(Firecrawl::V1::CrawlResponse)
      expect(result.success).to be true
      # result.id
      # => '407a88ac-dd36-48d7-8a41-784869a95a73'
    end

    it '[GET] /crawl/{:id}', :vcr do
      result = subject.crawl_status('407a88ac-dd36-48d7-8a41-784869a95a73')
      expect(result).to be_a(Firecrawl::V1::CrawlStatusResponse)
      expect(result.success).to be true
    end

    it '[DELETE] /crawl/{:id}', :vcr do
      result = subject.cancel_crawl('407a88ac-dd36-48d7-8a41-784869a95a73')
      expect(result).to be_a(Firecrawl::V1::CancelCrawlResponse)
      expect(result.status).to eq 'cancelled'
    end

    it '[GET] /crawl/{:id}/errors', :vcr do
      result = subject.crawl_errors('407a88ac-dd36-48d7-8a41-784869a95a73')
      expect(result).to be_a(Firecrawl::V1::CrawlErrorsResponse)
    end

    it '[GET] /crawl/active', :vcr do
      result = subject.active_crawls
      expect(result).to be_a(Firecrawl::V1::ActiveCrawlsResponse)
    end
  end

  # Map Endpoints
  
  it '[POST] /map', :vcr do
    result = subject.map(test_page)
    expect(result).to be_a(Firecrawl::V1::MapResponse)
    expect(result.success).to be true
  end

  # Search Endpoints

  it '[POST] /search', :vcr do
    result = subject.search('firecrawlについて')
    expect(result).to be_a(Firecrawl::V1::SearchResponse)
    expect(result.success).to be true
  end

  # Extract Endpoints
  
  it '[POST] /extract', :vcr do
    result = subject.extract(test_page)
    expect(result).to be_a(Firecrawl::V1::ExtractResponse)
    expect(result.success).to be true
  end

  it '[GET] /extract/{:id}', :vcr do
    result = subject.extract_status(test_page)
    expect(result.success).to be true
    expect(result.data).to be_a(Firecrawl::V1::Document)
    expect(result.data.metadata).to be_a(Firecrawl::V1::Metadata)
  end

  # Account Endpoints

end
