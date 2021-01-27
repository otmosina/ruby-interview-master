# frozen_string_literal: true

module JSONAPI
  module Rails
    class DryValidationErrorsSerializer
      def initialize(exposures)
        @dry_result = exposures[:object]

        freeze
      end

      def as_jsonapi
        dry_result.errors.to_h.each_pair do |key, errors|
          SerializableActiveModelError
            .new(field: key, message: errors, pointer: "/data/attributes/#{key}")
            .as_jsonapi
        end
      end

      private

      attr_reader :dry_result
    end
  end
end
