# frozen_string_literal: true

module SchemaExtractor
  class Schema
    attr_reader :fields
    attr_reader :name

    def initialize(name)
      @name = name
      @fields = []
    end

    def add(field)
      fields.push(field)
    end
  end
end
