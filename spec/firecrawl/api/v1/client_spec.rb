# frozen_string_literal: true

require "spec_helper"

RSpec.describe Firecrawl::API::V1::Client do

  let(:client) { Firecrawl::API::V1::Client.new(debug: false) }
  let(:test_page) { 'https://www.firecrawl.dev' }

  #
  it "/v1/scrape" do
    result = client.scrape(test_page, formats: ['markdown', 'html', 'rawHtml'], timeout: 12000)

    expect(result.parsed_response).to match(
      a_hash_including(
        'success' => true, 
        'data' => a_hash_including(
          'markdown' => a_string_matching(/.+/),
          'html' => a_string_matching(/.+/),
          'rawHtml' => a_string_matching(/.+/),
          "metadata" => a_hash_including(
            'title' => a_string_matching(/.+/)
          )
        )
      )
    )
  end

  # #
  # it "/v1/scrape with screenshot" do
  #   result = client.scrape(test_page, formats: ['markdown', 'screenshot'], timeout: 12000)

  #   expect(result.parsed_response).to match(
  #     a_hash_including(
  #       'success' => true, 
  #       'data' => a_hash_including(
  #         'markdown' => a_string_matching(/.+/),
  #         'screenshot' => a_string_matching(/.+/),
  #         "metadata" => a_hash_including(
  #           'title' => a_string_matching(/.+/)
  #         )
  #       )
  #     )
  #   )
  # end

  it "/v1/crawl" do
    result = client.crawl(test_page)

    expect(result.parsed_response).to match(
      a_hash_including(
        'success' => true, 
        'id' => a_string_matching(/.+/),
        'url' => a_string_matching(/.+/)
      )
    )

    crawl_id = result['id']

    puts "Crawl ID: #{crawl_id}"

    result = client.get_crawl_status(crawl_id)


    result = client.cancel_crawl(crawl_id)
    expect(result.parsed_response).to match(
      a_hash_including(
        'success' => true, 
        'message' => a_string_matching('Crawl job successfully cancelled.'),
      )
    )
  end

end
