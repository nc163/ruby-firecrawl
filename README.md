# Ruby Firecrawl

This is a library written in Ruby to communicate with [Firecrawl](https://www.firecrawl.dev).


## Installation

```Gemfile
gem 'ruby-firecrawl', github: "nc163/ruby-firecrawl"
```

## Usage

simple
```ruby
require 'firecrawl'

firecrawl = Firecrawl::V2::Client.new(url: 'http://127.0.0.1:3002')
firecrawl.scrape('https://www.firecrawl.dev')
```

or if rails, create a file in `config/initializers/firecrawl.rb` and add the following code:

```ruby
require 'firecrawl'

#= initialize
Firecrawl::configure do |config|
  config.url = 'http://127.0.0.1:3002'
end
```

### scrape

```ruby
firecrawl = Firecrawl::V2::Client.new
firecrawl.scrape('https://www.firecrawl.dev')
```


### scrape + extract

```ruby
firecrawl = Firecrawl::V2::Client.new
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
firecrawl.scrape('https://www.firecrawl.dev', formats: ['extract'], timeout: 12000, extract: extract)
```


### crawl

```ruby
firecrawl = Firecrawl::V2::Client.new
firecrawl.crawl('https://www.firecrawl.dev')
```
