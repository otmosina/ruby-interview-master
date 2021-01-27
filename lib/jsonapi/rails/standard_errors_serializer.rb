# frozen_string_literal: true

module JSONAPI
  module Rails
    class StandardErrorsSerializer
      def initialize(exposures)
        @error = exposures[:object]

        freeze
      end

      def as_jsonapi
        SerializableActiveModelError
          .new(message: error.message, pointer: '')
          .as_jsonapi
      end

      private

      attr_reader :error
    end
  end
end
