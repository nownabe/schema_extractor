# frozen_string_literal: true

require "io/console"

require "mysql2"

require "schema_extractor/field"
require "schema_extractor/schema"

module SchemaExtractor
  module Mysql
    class UnknownFieldTypeError < StandardError; end

    class Extractor
      attr_reader :options

      def initialize(options)
        @options = options
      end

      def extract
        tables.map { |t| get_schema(t) }
      end

      private

      def ask_password
        print "Password: "
        STDIN.noecho(&:gets).chomp.tap { puts }
      end

      def build_field(row)
        Field.new(
          name: detect_name(row),
          type: detect_type(row),
          nullable: detect_nullable(row),
          default: detect_default_value(row)
        )
      end

      def client
        @client ||= Mysql2::Client.new(
          host: options.fetch(:host, "localhost"),
          port: options.fetch(:port, "3306"),
          username: options.fetch(:user, "root"),
          password: options.fetch(:password) { ask_password },
          database: options.fetch(:database)
        )
      end

      def detect_default_value(row)
        if !row["Default"].nil? && detect_type(row) == :boolean
          return row["Default"] == 0 ? false : true
        end
        row["Default"]
      end

      def detect_name(row)
        row["Field"]
      end

      def detect_nullable(row)
        row["Null"] == "YES"
      end

      def detect_type(row)
        case row["Type"]
        when /^tinyint\(1\)$/
          :boolean
        when /^date$/
          :date
        when /^datetime$/
          :datetime
        when /^decimal\(\d+,\d+\)$/
          :decimal
        when /^float$/
          :float
        when /^bigint\(\d+\)$/, /^int\(\d+\)$/, /^smallint\(\d+\)$/, /^tinyint\(\d+\)$/
          :integer
        when /^longtext$/, /^text$/, /^varchar\(\d+\)$/
          :string
        else
          raise UnknownFieldTypeError, "#{row['Type']} is unknown type."
        end
      end

      def get_schema(table)
        schema = Schema.new(table)
        client.query("describe #{table}").each { |r| schema.add(build_field(r)) }
        schema
      end

      def tables
        @tables ||= client.query("show tables").map { |row| row.values.first }
      end
    end
  end
end
