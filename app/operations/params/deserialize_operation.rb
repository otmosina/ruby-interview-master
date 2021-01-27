# frozen_string_literal: true

module Params
  class DeserializeOperation < ApplicationOperation
    include ::Dry::Monads::Try::Mixin

    def initialize(deserializer: ::Api::V1::BaseDeserializer)
      self.deserializer = deserializer
    end

    def call(input, skip_validation: false)
      Try(JSONAPI::Parser::InvalidDocument) do
        input = input.fetch(:_jsonapi, input).slice('data')
        JSONAPI.parse_resource!(input) unless skip_validation

        deserializer.call(input.fetch('data', {}))
      end.to_result
    end

    private

    attr_accessor :deserializer
  end
end
