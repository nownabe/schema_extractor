# SchemaExtractor

Extract DB schema and output as specific format.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'schema_extractor'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install schema_extractor

## Usage

```bash
$ exe/schema_extractor --help
usage: schema_extractor [options]
    -s, --source    Source database type. Supported sources: mysql
    -f, --format    Output format. Supported formats: bq, bigquery
    -o, --output    Output directory.
    -h, --host      Host of database.
    -u, --user      User of database.
    -p, --password  Password of database.
    -P, --port      Port of database.
    -d, --database  Database name.
    -v, --version   Show version.
    --help          Show this message.
```

Example:

```bash
$ schema_extractor -s mysql -f bigquery -h 127.0.0.1 -u dbuser -d mydb -p dbpass -o tmp
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nownabe/schema_extractor.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

