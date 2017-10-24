# frozen_string_literal: true

module SchemaExtractor
  module Formatters
    FORMATTERS = {
      bq: "bigquery",
      bigquery: "bigquery",
    }.freeze

    class << self
      def formats
        FORMATTERS.keys
      end

      def get_formatter(format)
        underscored_name = FORMATTERS[format.to_sym]
        require "schema_extractor/formatters/#{underscored_name}"
        klass = SchemaExtractor::Formatters.const_get(underscored_name.capitalize)
        klass.new
      end
    end
  end
end
