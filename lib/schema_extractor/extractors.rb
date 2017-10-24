# frozen_string_literal: true

module SchemaExtractor
  module Extractors
    EXTRACTORS = {
      mysql: "mysql",
    }.freeze

    class << self
      def sources
        EXTRACTORS.keys
      end

      def get_extractor(source, options)
        underscored_name = EXTRACTORS[source.to_sym]
        require "schema_extractor/#{underscored_name}/extractor"
        klass = SchemaExtractor.const_get("#{underscored_name.capitalize}::Extractor")
        klass.new(options)
      end
    end
  end
end
