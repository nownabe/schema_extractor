# frozen_string_literal: true

require "json"

module SchemaExtractor
  module Formatters
    class Bigquery
      class InvalidBigqueryFieldTypeError < StandardError; end

      def format(schema)
        JSON.pretty_generate(
          schema.fields.map do |f|
            {
              name: f.name,
              type: bq_type(f),
              mode: bq_mode(f)
            }
          end
        )
      end

      def extension
        ".json"
      end

      private

      def bq_mode(f)
        f.nullable? && f.default.nil? ? "NULLABLE" : "REQUIRED"
      end

      def bq_type(f)
        case f.type
        when :boolean
          "BOOL"
        when :decimal, :float
          "FLOAT"
        when :integer
          "INTEGER"
        when :string
          "STRING"
        when :date
          "DATE"
        when :datetime
          "TIMESTAMP"
        else
          raise InvalidBigqueryFieldTypeError, "#{f.type} is invalid type for bigquery field."
        end
      end
    end
  end
end
