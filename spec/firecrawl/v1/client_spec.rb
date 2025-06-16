# frozen_string_literal: true

require "spec_helper"

describe Firecrawl::V1::Client do
  subject { described_class.new('http://host.docker.internal:3002') }
  let(:test_page) { 'https://www.firecrawl.dev' }
  let(:test_pages) { ['https://www.firecrawl.dev', 'https://rubygems.org/'] }
  let(:test_bad_pages) { ['https://httpstat.us/404'] }

  context "Scrape Endpoints" do
    it 'is scrape response' do
      result = subject.scrape(test_page)
      expect(result).to be_a(Firecrawl::V1::ScrapeResponse)
      expect(result.success).to be true
      expect(result.data).to be_a(Firecrawl::V1::Document)
      expect(result.data.metadata).to be_a(Firecrawl::V1::Metadata)
    end
  end

  context "Batch Scrape Endpoints" do 
    it 'posts batch scrape, checks status, and cancels the job' do
      batch_id = nil

      # POST
      post_result = subject.batch_scrape(test_pages, waitFor: 1000)
      expect(post_result).to be_a(Firecrawl::V1::BatchScrapeResponse)
      expect(post_result.success).to be true
      expect(post_result.id).to be_a(String)

      batch_id = post_result.id
      sleep 1

      # GET
      status_result = subject.batch_scrape_status(batch_id)
      expect(status_result).to be_a(Firecrawl::V1::BatchScrapeStatusResponse)
      expect(status_result.total).to eq test_pages.length

      sleep 1

      # DELETE
      cancel_result = subject.cancel_batch_scrape(batch_id)
      expect(cancel_result).to be_a(Firecrawl::V1::CancelBatchScrape)
      expect(cancel_result.success).to be true
    end

    it 'posts batch scrape, and retrieves errors' do
      batch_id = nil

      # POST
      post_result = subject.batch_scrape(test_bad_pages, waitFor: 1000)
      expect(post_result).to be_a(Firecrawl::V1::BatchScrapeResponse)
      expect(post_result.success).to be true
      expect(post_result.id).to be_a(String)

      batch_id = post_result.id
      sleep 1

      # GET errors
      errors_result = subject.get_batch_scrape_errors(batch_id)
      expect(errors_result).to be_a(Firecrawl::V1::BatchScrapeErrors)
      expect(errors_result.errors).to be_an(Array)
    end

  end

  context "Crawl Endpoints" do

  end
  # # Crawl Endpoints

  # describe "POST /v1/crawl" do
  #   it 'is crawl response' do
  #     result = client.crawl(test_page)
  #     expect(result).to be_a(Firecrawl::V1::CrawlResponse)
  #   end
  # end

  # describe "GET /v1/crawl/{:id}" do
  #   it 'is crawl response' do
  #     result = client.get_crawl_status(job_id)
  #     expect(result).to be_a(Firecrawl::V1::CrawlResponse)
  #   end
  # end

  # describe "DELETE /v1/crawl/{:id}" do
  #   it 'is cancel_crawl response' do
  #     result = client.cancel_crawl(job_id)
  #     expect(result).to be_a(Firecrawl::V1::CancelCrawl)
  #   end
  # end

  # describe "GET /v1/crawl/{:id}/errors" do
  #   it 'is crawl_errors response' do
  #     result = client.get_crawl_errors(job_id)
  #     expect(result).to be_a(Firecrawl::V1::CrawlErrors)
  #   end
  # end

  # describe "GET /v1/crawl/active" do
  #   it 'is active_crawl response' do
  #     result = client.active_crawl
  #     expect(result).to be_a(Firecrawl::V1::ActiveCrawl)
  #   end
  # end

  # # Map Endpoints

  # describe "POST /v1/map" do
  #   it 'is map response' do
  #     result = client.map(test_page)
  #     expect(result).to be_a(Firecrawl::V1::MapResponse)
  #   end
  # end

  # # Search Endpoints
  
  # describe "POST /v1/search" do
  #   it 'is search response' do
  #     result = client.search('firecrawl')
  #     expect(result).to be_a(Firecrawl::V1::SearchResponse)
  #   end
  # end    

  # # Extract Endpoints

  # describe "POST /v1/extract" do
  #   it 'is extract response' do
  #     result = client.extract(test_pages)
  #     expect(result).to be_a(Firecrawl::V1::ExtractResponse)
  #   end
  # end

  # describe "GET /v1/extract/{:id}" do
  #   it 'is extract_status response' do
  #     result = client.extract_status(id)
  #     expect(result).to be_a(Firecrawl::V1::ExtractStatusResponse)
  #   end
  # end

end
