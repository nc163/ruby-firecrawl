# frozen_string_literal: true

require "spec_helper"

# https://docs.firecrawl.dev/api-reference/introduction
describe Firecrawl::V1 do

  describe Firecrawl::V1::ScrapeResponse do
    it ''  do
      fixture = load_fixture('v1/scrape/index.json')
      response = described_class.new(fixture)
      expect(response.success).to be(true)
      expect(response.data).to be_a(Firecrawl::V1::Document)

      expect(response.data.markdown).to be_a(String)
      expect(response.data.html).to be_a(String)
      expect(response.data.rawHtml).to be_a(String)
      expect(response.data.screenshot).to be_a(String)
      expect(response.data.links).to be_a(Array)
      expect(response.data.actions).to be_a(Hash)
      expect(response.data.metadata).to be_a(Firecrawl::V1::Metadata)
      expect(response.data.llm_extraction).to be_a(Hash)
      expect(response.data.warning).to be_a(String)
      expect(response.data.changeTracking).to be_a(Hash)
    end
  end

  describe Firecrawl::V1::BatchScrapeResponse do
    it '' do
      fixture = load_fixture('v1/batch/scrape/index.json')
      response = described_class.new(fixture)

      expect(response.success).to be(true)
      expect(response.id).to eq(fixture['id'])
      expect(response.url).to eq(fixture['url'])
      expect(response.invalidURLs).to eq(fixture['invalidURLs'])
    end
  end

  describe Firecrawl::V1::BatchScrapeStatusResponse do
    it '' do
      fixture = load_fixture('v1/batch/scrape/[:id].json')
      response = described_class.new(fixture)
      expect(response.status).to eq(fixture['status'])
      expect(response.total).to eq(fixture['total'])
      expect(response.completed).to eq(fixture['completed'])
      expect(response.creditsUsed).to eq(fixture['creditsUsed'])
      expect(response.expiresAt).to eq(fixture['expiresAt'])
      expect(response.next).to eq(fixture['next'])
      expect(response.data).to be_a(Array)
    end
  end

  # describe Firecrawl::V1::CancelBatchScrape do
  #   it '' do
  #     fixture = load_fixture('v1/cancel_batch_scrape.json')
  #     response = described_class.new(fixture)
  #     expect(response.success).to eq(fixture['success'])
  #     expect(response.message).to eq(fixture['message'])
  #   end
  # end

  describe Firecrawl::V1::BatchScrapeErrors do
    it '' do
      fixture = load_fixture('v1/batch/scrape/[:id]/errors.json')
      response = described_class.new(fixture)
      expect(response.errors).to eq(fixture['errors'])
      expect(response.robotsBlocked).to eq(fixture['robotsBlocked'])
    end
  end

  # Crawl Endpoints

  describe Firecrawl::V1::CrawlResponse do
    it '' do
      fixture = load_fixture('v1/crawl/index.json')
      response = described_class.new(fixture)
      expect(response.success).to eq(fixture['success'])
      expect(response.id).to eq(fixture['id'])
      expect(response.url).to eq(fixture['url'])
    end
  end

  describe Firecrawl::V1::CrawlStatusResponse do
    it '' do
      fixture = load_fixture('v1/crawl/[:id].json')
      response = described_class.new(fixture)
      expect(response.status).to eq(fixture['status'])
      expect(response.total).to eq(fixture['total'])
      expect(response.completed).to eq(fixture['completed'])
      expect(response.creditsUsed).to eq(fixture['creditsUsed'])
      expect(response.expiresAt).to eq(fixture['expiresAt'])
      expect(response.next).to eq(fixture['next'])
      expect(response.data).to be_a(Array)
    end
  end

  # describe Firecrawl::V1::CancelCrawlResponse do
  #   it '' do
  #     fixture = load_fixture('v1/cancel_crawl.json')
  #     response = described_class.new(fixture)
  #     expect(response.status).to eq(fixture['status'])
  #   end
  # end
  

  describe Firecrawl::V1::CrawlErrorsResponse do
    it '' do
      fixture = load_fixture('v1/crawl/[:id]/errors.json')
      response = described_class.new(fixture)
      expect(response.errors).to eq(fixture['errors'])
      expect(response.robotsBlocked).to eq(fixture['robotsBlocked'])
    end
  end
  

  describe Firecrawl::V1::ActiveCrawlsResponse do
    it '' do
      fixture = load_fixture('v1/crawl/active.json')
      response = described_class.new(fixture)
    end
  end

  # Map Endpoints

  describe Firecrawl::V1::MapResponse do
    it '' do
      fixture = load_fixture('v1/map/index.json')
      response = described_class.new(fixture)
      expect(response.status).to eq(fixture['status'])
      expect(response.links).to eq(fixture['links'])
    end
  end

  # Search Endpoints

  describe Firecrawl::V1::SearchResponse do
    it '' do
      fixture = load_fixture('v1/search/index.json')
      response = described_class.new(fixture)
      expect(response.status).to eq(fixture['status'])
      expect(response.data).to be_a(Array)
      expect(response.warning).to eq(fixture['warning'])
    end
  end

  # Extract Endpoints

  describe Firecrawl::V1::ExtractResponse do
    it '' do
      fixture = load_fixture('v1/extract/index.json')
      response = described_class.new(fixture)
      expect(response.success).to eq(fixture['success'])
      expect(response.id).to eq(fixture['id'])
      expect(response.invalidURLs).to eq(fixture['invalidURLs'])
    end
  end

  describe Firecrawl::V1::ExtractStatusResponse do
    it '' do
      fixture = load_fixture('v1/extract/[:id].json')
      response = described_class.new(fixture)
      expect(response.success).to eq(fixture['success'])
      # expect(response.data).to be_a(AnyObject)
      expect(response.status).to eq(fixture['status'])
      expect(response.expiresAt).to eq(fixture['expiresAt'])
    end
  end

  # Account Endpoints

end
