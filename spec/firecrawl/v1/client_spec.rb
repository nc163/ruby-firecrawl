# frozen_string_literal: true

require "spec_helper"

describe Firecrawl::V1::Client do
  subject { described_class.new }
  let(:test_page) { 'https://www.firecrawl.dev' }
  let(:test_pages) { ['https://www.firecrawl.dev', 'https://rubygems.org/'] }

  #
  context 'Scrape Endpoint', :vcr do
    let!(:scrape) { subject.scrape(test_page) }

    it '[POST] /scrape' do
      expect(scrape).to be_a(Firecrawl::V1::Scrape)
    end
  end

  #
  context "Batch Scrape Endpoint", :vcr do
    let!(:batch_scrape) { subject.batch_scrape(test_pages) }

    it '[POST] /batch/scrape' do
      expect(batch_scrape).to be_a(Firecrawl::V1::BatchScrape)
    end

    context "Batch Scrape Status" do
      let!(:batch_scrape_status) { subject.batch_scrape_status(batch_scrape.id) }

      it '[GET] /batch/scrape/{:id}' do
        expect(batch_scrape_status).to be_a(Firecrawl::V1::BatchScrapeStatus)
        expect(batch_scrape_status.data).to all(be_a(Firecrawl::V1::Document))
      end
    end

    context "Cancel Batch Scrape" do
      let!(:batch_scrape) { subject.batch_scrape(test_pages) }
      let!(:cancel_batch_scrape) { subject.cancel_batch_scrape(batch_scrape.id) }

      it '[DELETE] /batch/scrape/{:id}' do
        expect(cancel_batch_scrape).to be_a(Firecrawl::V1::CancelBatchScrape)
      end
    end

    context "Batch Scrape Errors" do
      let!(:batch_scrape) { subject.batch_scrape(test_pages) }
      let!(:batch_scrape_errors) { subject.batch_scrape_errors(batch_scrape.id) }

      it '[GET] /batch/scrape/{:id}/errors' do
        expect(batch_scrape_errors).to be_a(Firecrawl::V1::BatchScrapeErrors)
      end
    end
  end

  #
  context "Crawl Endpoint", :vcr do
    let!(:crawl) { subject.crawl(test_page) }

    it '[POST] /crawl' do
      expect(crawl).to be_a(Firecrawl::V1::Crawl)
    end

    context "Crawl Status" do
      let!(:crawl_status) { subject.crawl_status(crawl.id) }

      it '[GET] /crawl/{:id}' do
        expect(crawl_status).to be_a(Firecrawl::V1::CrawlStatus)
        expect(crawl_status.data).to all(be_a(Firecrawl::V1::Document))
      end
    end

    context "Crawl Errors" do
      let!(:crawl_errors) { subject.crawl_errors(crawl.id) }

      it '[GET] /crawl/{:id}/errors' do
        expect(crawl_errors).to be_a(Firecrawl::V1::CrawlErrors)
      end
    end

    context "Active Crawls" do
      let!(:active_crawls) { subject.active_crawls }

      it '[GET] /crawl/active' do
        expect(active_crawls).to be_a(Firecrawl::V1::ActiveCrawls)
      end
    end

    context "Cancel Crawls" do
      let!(:cancel_crawl) { subject.cancel_crawl(crawl.id) }

      it '[DELETE] /crawl/{:id}' do
        expect(cancel_crawl).to be_a(Firecrawl::V1::CancelCrawl)
      end
    end
  end

  #
  context "Map Endpoint", :vcr do
    let!(:map) { subject.map(test_page) }

    it '[POST] /map' do
      expect(map).to be_a(Firecrawl::V1::Map)
    end
  end

  #
  context "Search Endpoint" do
    let!(:search) { subject.search('firecrawlについて') }

    it '[POST] /search' do
      expect(search).to be_a(Firecrawl::V1::Search)
    end
  end

  #
  context "Extract Endpoint", :vcr do
    let!(:extract) { subject.extract(test_pages) }

    it '[POST] /extract' do
      expect(extract).to be_a(Firecrawl::V1::Extract)
    end

    context "Extract Status" do
      let!(:extract_status) { subject.extract_status(extract.id) }

      it '[GET] /extract/{:id}' do
        expect(extract_status).to be_a(Firecrawl::V1::ExtractStatus)
      end
    end
  end

  #
  context "Account Endpoint", :vcr do

    context "Credit" do
      let!(:credit) { subject.credit }

      it '[GET] /team/credit-usage' do
        expect(credit).to be_a(Firecrawl::V1::CreditUsage)
      end
    end

    context "Credit Historical" do
      let!(:credit_historical) { subject.credit_historical }

      it '[GET] /team/credit-usage/historical' do
        expect(credit_historical).to be_a(Firecrawl::V1::CreditHistorical)
      end
    end

    context "Token" do
      let!(:token) { subject.token }

      it '[GET] /team/token-usage' do
        expect(token).to be_a(Firecrawl::V1::TokenUsage)
      end
    end

    context "Token Usage Historical" do
      let!(:token_historical) { subject.token_historical }

      it '[GET] /team/token-usage/historical' do
        expect(token_historical).to be_a(Firecrawl::V1::TokenHistorical)
      end
    end

    context "Queue" do
      let!(:queue) { subject.queue }

      it '[GET] /team/queue' do
        expect(queue).to be_a(Firecrawl::V1::QueueStatus)
      end
    end
  end
end
