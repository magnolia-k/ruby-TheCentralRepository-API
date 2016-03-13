# TheCentralRepository::API

API for search The Central Repository

```ruby
require 'TheCentralReposiroy/API'
result = TheCentralRepository::API.search_by_keyword('scala-dist')
```

  p vers[:artifacts][0] # top score search result

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'TheCentralRepository-API'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install TheCentralRepository-API

## Usage

```ruby
require 'TheCentralReposiroy/API'
result = TheCentralRepository::API.search_by_keyword('scala-dist')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/magnolia-k/ruby-TheCentralRepository-API](https://github.com/magnolia-k/ruby-TheCentralRepository-API).

