# frozen_string_literal: true

require "spec_helper"

describe Firecrawl::HTTP do
  subject { Firecrawl::V1::Client.new }
  let (:stub_url) { "#{ENV['FIRECRAWL_ENDPOINT']}/v1/scrape" }

  # 400 Bad Request
  context do
    let (:error_message) { 'Payment required to access this resource.' }
    before do
      stub_request(:post, stub_url)
        .with(headers: { 'Accept' => 'application/json' })
        .to_return(
          status: 400,
          body: { message: error_message }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'BadRequestError' do
      expect { subject.scrape('example.com') }.to raise_error(Firecrawl::BadRequestError) { |error|
        expect(error.message).to eq(error_message)
      }
    end
  end

  # 401 Unauthorized
  context do
    let (:error_message) { 'Unauthorized' }
    before do
      stub_request(:post, stub_url)
        .with(headers: { 'Accept' => 'application/json' })
        .to_return(
          status: 401,
          body: { message: error_message }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'UnauthorizedError' do
      expect { subject.scrape('example.com') }.to raise_error(Firecrawl::UnauthorizedError) { |error|
        expect(error.message).to eq(error_message)
      }
    end
  end

  # 402 Payment Required
  context do
    let (:error_message) { 'Payment required to access this resource.' }
    before do
      stub_request(:post, stub_url)
        .with(headers: { 'Accept' => 'application/json' })
        .to_return(
          status: 402,
          body: { message: error_message }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'PaymentRequiredError' do
      expect { subject.scrape('example.com') }.to raise_error(Firecrawl::PaymentRequiredError) { |error|
        expect(error.message).to eq(error_message)
      }
    end
  end

  # 404 Not Found
  context do
    let (:error_message) { 'Batch scrape job not found.' }
    before do
      stub_request(:post, stub_url)
        .with(headers: { 'Accept' => 'application/json' })
        .to_return(
          status: 404,
          body: { message: error_message }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'ResourceNotFound' do
      expect { subject.scrape('example.com') }.to raise_error(Firecrawl::ResourceNotFound) { |error|
        expect(error.message).to eq(error_message)
      }
    end
  end

  # 408 Not Found
  context do
    let (:error_message) { 'Request timed out.' }
    before do
      stub_request(:post, stub_url)
        .with(headers: { 'Accept' => 'application/json' })
        .to_return(
          status: 408,
          body: { message: error_message }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'ResourceNotFound' do
      expect { subject.scrape('example.com') }.to raise_error(Firecrawl::RequestTimeoutError) { |error|
        expect(error.message).to eq(error_message)
      }
    end
  end

  # 429 Too Many Requests
  context do
    let (:error_message) { 'Request rate limit exceeded. Please wait and try again later.' }
    before do
      stub_request(:post, stub_url)
        .with(headers: { 'Accept' => 'application/json' })
        .to_return(
          status: 429,
          body: { message: error_message }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'TooManyRequestsError' do
      expect { subject.scrape('example.com') }.to raise_error(Firecrawl::TooManyRequestsError) { |error|
        expect(error.message).to eq(error_message)
      }
    end
  end

  # 5xx Server Error
  context do
    let (:error_message) { 'An unexpected error occurred on the server.' }
    before do
      stub_request(:post, stub_url)
        .with(headers: { 'Accept' => 'application/json' })
        .to_return(
          status: 500,
          body: { message: error_message }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'TooManyRequestsError' do
      expect { subject.scrape('example.com') }.to raise_error(Firecrawl::ServerError) { |error|
        expect(error.message).to eq(error_message)
      }
    end
  end
end
