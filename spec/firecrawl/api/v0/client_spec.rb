# frozen_string_literal: true

require "spec_helper"

RSpec.describe Firecrawl::API::V0::Client do

  let(:firecrawl) { Firecrawl::API::V0::Client.new(debug: false) }

  #
  # == scrape
  #

  #
  it "scrape" do
    result = firecrawl.scrape('https://www.firecrawl.dev', timeout: 12000)

    expect(result.parsed_response).to match(
      a_hash_including(
        'success' => true, 
        'data' => a_hash_including(
          'markdown' => anything,
          'content' => anything,
          'metadata' => anything
        ),
        'returnCode' => 200
      )
    )
    expect(result.parsed_response['data']).not_to include('html')
    expect(result.parsed_response['data']).not_to include('rawHtml')
    expect(result.parsed_response['data']).not_to include('llm_extraction')
    expect(result.parsed_response['data']).not_to include('warning')
  end

  it "scrape page_options" do
    options = firecrawl.scrape_page_options(
      # screenshot: true,
      include_html: true,
      # include_raw_html: true
      wait_for: 10000
    )
    expect(options).to match(
      a_hash_including(
        'includeHtml' => true,
        'waitFor' => 10000
      )
    )
  end

  it "scrape extractor_options" do
    extractor_options = firecrawl.scrape_extractor_options(
      mode: 'markdown', 
      extraction_prompt: 'any prompt', 
      extraction_schema: {}
    )

    expect(extractor_options).to match(
      a_hash_including(
        'mode' => 'markdown',
        'extractionPrompt' => 'any prompt',
        'extractionSchema' => {}
      )
    )
  end

  #
  it "scrape use page_options" do
    page_options = firecrawl.scrape_page_options(include_html: true, wait_for: 5)
    result = firecrawl.scrape('https://www.firecrawl.dev',
      page_options: page_options,
      timeout: 12000
    )
    
    expect(result.parsed_response).to match(
      a_hash_including(
        'success' => true, 
        'data' => a_hash_including(
          'markdown' => anything,
          'content' => anything,
          'metadata' => anything,
          'html' => anything
        ),
        'returnCode' => 200
      )
    )
    expect(result.parsed_response['data']).not_to include('rawHtml')
    expect(result.parsed_response['data']).not_to include('llm_extraction')
    expect(result.parsed_response['data']).not_to include('warning')
  end


  # #
  # it "scrape use extractor_options" do
  #   extractor_options = firecrawl.scrape_extractor_options(mode: true, extraction_prompt: 5, extraction_schema: {})
  #   result = firecrawl.scrape('https://www.firecrawl.dev',
  #     extractor_options: extractor_options,
  #     timeout: 12000
  #   )
    
  #   expect(result.parsed_response).to match(
  #     a_hash_including(
  #       'success' => true, 
  #       'data' => a_hash_including(
  #         'markdown' => anything,
  #         'content' => anything,
  #         'metadata' => anything,
  #         'llm_extraction' => anything,
  #       ),
  #       'returnCode' => anything
  #     )
  #   )
  #   expect(result.parsed_response['data']).not_to include('html')
  #   expect(result.parsed_response['data']).not_to include('rawHtml')
  #   expect(result.parsed_response['data']).not_to include('warning')
  # end


  #
  # == crawl
  #

  #
  # it "crawl" do
  #   result = firecrawl.crawl('https://www.firecrawl.dev')
  #   job_id = result['jobId']

  #   expect(result.parsed_response).to match(
  #     a_hash_including(
  #       'jobId' => anything
  #     )
  #   )

  #   sleep(1)
  #   crawl_status_result = firecrawl.crawl_status(job_id)
  #   expect(crawl_status_result.parsed_response).to match(
  #     a_hash_including(
  #       'status' => anything,
  #       'current' => anything,
  #       'current_url' => anything,
  #       'current_step' => anything,
  #       'total' => anything,
  #       'data' => anything,
  #       'partial_data' => anything
  #     )
  #   )

  #   sleep(5)
  #   crawl_cancel_result = firecrawl.crawl_cancel(job_id)
  #   expect(crawl_cancel_result.parsed_response).to match(
  #     a_hash_including(
  #       'status' => anything
  #     )
  #   )
  # end

  #
  it "crawl page_options" do
    options = firecrawl.crawl_page_options(
      headers: {},
      include_html: true,
      include_raw_html: true
    )
    expect(options).to match(
      a_hash_including(
        'headers' => {},
        'includeHtml' => true,
        'includeRawHtml' => true
      )
    )
  end

  #
  # search
  #

  # #
  # it "search" do
  #   result = firecrawl.search('what is firecrawl')
  # end

end
