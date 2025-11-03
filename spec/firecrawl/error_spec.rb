# frozen_string_literal: true

require "spec_helper"

describe Firecrawl::HTTP do
  subject { Firecrawl::V1::Client.new('http://host.docker.internal:3002') }

  it 'BadRequestError', :vcr do
    expect { subject.scrape('bad request') }.to raise_error(Firecrawl::BadRequestError)
  end

  it 'UnauthorizedError', :vcr do
    expect { subject.scrape('') }.to raise_error(Firecrawl::UnauthorizedError)
  end

  it 'PaymentRequiredError', :vcr do
    expect { subject.scrape('') }.to raise_error(Firecrawl::PaymentRequiredError)
  end

  it 'ResourceNotFound', :vcr do
    expect { subject.scrape('http://host.docker.internal:8000') }.to raise_error(Firecrawl::ResourceNotFound)
  end

  it 'TooManyRequestsError', :vcr do
    expect { subject.scrape('') }.to raise_error(Firecrawl::TooManyRequestsError)
  end
end
