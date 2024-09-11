# Ruby Firecrawl

This is a library written in Ruby to communicate with [Firecrawl](https://www.firecrawl.dev).
Many functions are not implemented.


## Installation

```Gemfile
gem 'ruby-firecrawl', github: "nc163/ruby-firecrawl"
```

## Usage

simple
```ruby
require 'firecrawl'

firecrawl = Firecrawl::API::V1::Client.new(url: 'http://127.0.0.1:3002')
result = firecrawl.scrape('https://www.firecrawl.dev')
```

or if rails, create a file in `config/initializers/firecrawl.rb` and add the following code:

```ruby
require 'firecrawl'

#= initialize
Firecrawl::configure do |config|
  # config.api_key = 'xxxx'
  config.url = 'http://127.0.0.1:3002'
end
```

### scrape

```ruby
firecrawl = Firecrawl::API::V1::Client.new
result = firecrawl.scrape('https://www.firecrawl.dev')
puts result
```


### scrape + extract

```ruby
firecrawl = Firecrawl::API::V1::Client.new

extract = { 
  schema: 
  {
    'type': 'object',
    'required': ['twitterAccountUrl', 'githubRepositoryUrl'],
    'properties': {
      'twitterAccountUrl': { "type": "string" },
      'githubRepositoryUrl': { "type": "string" }
    }
  }
}
result = client.scrape('https://www.firecrawl.dev', formats: ['extract'], timeout: 12000, extract: extract)
puts result
```


### crawl

```ruby
firecrawl = Firecrawl::API::V1::Client.new
result = firecrawl.crawl('https://www.firecrawl.dev')
puts result
```
