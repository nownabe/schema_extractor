# frozen_string_literal: true

module SchemaExtractor
  class Field
    class InvalidFieldNameError < StandardError; end
    class InvalidFieldTypeError < StandardError; end
    class InvalidNullableValueError < StandardError; end

    TYPES = %i[
      date
      datetime
      decimal
      float
      integer
      string
    ].freeze
    attr_reader :name
    attr_reader :type
    attr_reader :nullable
    attr_reader :default

    def initialize(name:, type:, nullable:, default: nil)
      @name = validate_name!(name)
      @type = validate_type!(type)
      @nullable = validate_nullable!(nullable)
      @default = validate_default!(default)
    end

    def nullable?
      nullable
    end

    private

    def validate_default!(default)
      default
    end

    def validate_name!(name)
      return name if name&.instance_of?(String) && !name.empty?
      raise InvalidFieldNameError, "#{name} is invalid field name."
    end

    def validate_nullable!(nullable)
      unless [true, false].include?(nullable)
        raise(InvalidNullableValueError, "#{nullable} is invalid for nullable value.")
      end
      nullable
    end

    def validate_type!(type)
      type = type&.to_sym
      return type if type && TYPES.include?(type)
      raise(InvalidFieldTypeError, "#{type} is invalid field type.")
    end
  end
end
