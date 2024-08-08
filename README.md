# Ruby Firecrawl

This is a library written in Ruby to communicate with [Firecrawl](https://www.firecrawl.dev).
Many functions are not implemented.


## Installation
```bash
gem 'ruby-firecrawl', github: "nc163/ruby-firecrawl"
bundle install
```

## Usage

or if rails, create a file in `config/initializers/firecrawl.rb` and add the following code:

```ruby
require 'firecrawl'

#= initialize
Firecrawl::configure do |config|
  # config.api_key = 'xxxx'
  config.url = 'http://127.0.0.1:3005'
end
```

### scrape

```ruby
Firecrawl::API::V0.scrape('http://example.com', timeout: 12000)
```


### crawl
