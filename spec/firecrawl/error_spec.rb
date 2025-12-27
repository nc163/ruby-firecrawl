# frozen_string_literal: true

require "spec_helper"

describe Firecrawl::HTTP do
  subject { Firecrawl::V1::Client.new }
  let (:stub_url) { "#{ENV['FIRECRAWL_ENDPOINT']}/v1/scrape" }

  # 400 Bad Request
  context do
    before do
      stub_request(:post, stub_url)
        .with(headers: { 'Accept' => 'application/json' })
        .to_return(
          status: 400,
          body: { message: 'bad request' }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'BadRequestError' do
      expect { subject.scrape('nop') }.to raise_error(Firecrawl::BadRequestError)
    end
  end

  # 401 Unauthorized
  context do
    before do
      stub_request(:post, stub_url)
        .with(headers: { 'Accept' => 'application/json' })
        .to_return(
          status: 401,
          body: { message: 'bad request' }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'UnauthorizedError' do
      expect { subject.scrape('nop') }.to raise_error(Firecrawl::UnauthorizedError)
    end
  end

  # 402 Payment Required
  context do
    before do
      stub_request(:post, stub_url)
        .with(headers: { 'Accept' => 'application/json' })
        .to_return(
          status: 402,
          body: { message: 'bad request' }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'PaymentRequiredError' do
      expect { subject.scrape('nop') }.to raise_error(Firecrawl::PaymentRequiredError)
    end
  end

  # 404 Not Found
  context do
    before do
      stub_request(:post, stub_url)
        .with(headers: { 'Accept' => 'application/json' })
        .to_return(
          status: 404,
          body: { message: 'Not Found' }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'ResourceNotFound' do
      expect { subject.scrape('http://host.docker.internal:8000') }.to raise_error(Firecrawl::ResourceNotFound)
    end
  end

  # 429 Too Many Requests
  context do
    before do
      stub_request(:post, stub_url)
        .with(headers: { 'Accept' => 'application/json' })
        .to_return(
          status: 429,
          body: { message: 'Not Found' }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'TooManyRequestsError' do
      expect { subject.scrape('nop') }.to raise_error(Firecrawl::TooManyRequestsError)
    end
  end

  # 5xx Server Error
  context do
    before do
      stub_request(:post, stub_url)
        .with(headers: { 'Accept' => 'application/json' })
        .to_return(
          status: 500,
          body: { message: 'Not Found' }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'TooManyRequestsError' do
      expect { subject.scrape('nop') }.to raise_error(Firecrawl::ServerError)
    end
  end
end
