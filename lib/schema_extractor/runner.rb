# frozen_string_literal: true

require "schema_extractor/extractors"
require "schema_extractor/formatters"
require "schema_extractor/option_parser"

module SchemaExtractor
  class Runner
    attr_reader :options

    def initialize(args)
      @options = OptionParser.new.parse(args)
    end

    def run
      schemas = extractor.extract
      schemas.each { |s| output(s) }
    end

    private

    def extractor
      SchemaExtractor::Extractors.get_extractor(options[:source], options.to_hash.compact)
    end

    def formatter
      @formatter ||= SchemaExtractor::Formatters.get_formatter(options[:format])
    end

    def output(schema)
      path = File.join(options[:output], "#{schema.name}#{formatter.extension}")
      File.write(path, formatter.format(schema))
    end
  end
end
