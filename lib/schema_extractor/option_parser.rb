# frozen_string_literal: true

require "slop"

require "schema_extractor/extractors"
require "schema_extractor/formatters"

module SchemaExtractor
  class OptionParser
    def parse(args)
      parser.parse(args)
    end

    private

    def banner
      "usage: schema_extractor [options]"
    end

    def formats
      Formatters.formats.join(", ")
    end

    def options
      Slop::Options.new do |o|
        o.banner = banner

        o.string(
          "-s",
          "--source",
          "Source database type. Supported sources: #{sources}",
          default: "mysql"
        )
        o.string(
          "-f",
          "--format",
          "Output format. Supported formats: #{formats}",
          default: "bigquery"
        )
        o.string(
          "-o",
          "--output",
          "Output directory.",
          default: "."
        )

        o.string "-h", "--host", "Host of database."
        o.string "-u", "--user", "User of database."
        o.string "-p", "--password", "Password of database."
        o.string "-P", "--port", "Port of database."
        o.string "-d", "--database", "Database name."

        o.on "-v", "--version", "Show version." do
          require "schema_extractor/version"
          puts SchemaExtractor::VERSION
          exit
        end

        o.on "--help", "Show this message." do
          puts o
          exit
        end
      end
    end

    def parser
      Slop::Parser.new(options)
    end

    def sources
      Extractors.sources.join(", ")
    end
  end
end
