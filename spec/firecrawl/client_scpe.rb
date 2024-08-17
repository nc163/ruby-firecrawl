# frozen_string_literal: true

require "spec_helper"

RSpec.describe Firecrawl::Client do

  it "initialize client" do
    expect(Firecrawl::Client.new).to be_a Firecrawl::Client
  end

end
