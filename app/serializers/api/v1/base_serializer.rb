# frozen_string_literal: true

module Api::V1
  class BaseSerializer < JSONAPI::Serializable::Resource
    extend JSONAPI::Serializable::Resource::ConditionalFields
    extend JSONAPI::Serializable::Resource::KeyFormat

    key_format ->(key) { key.to_s.camelize(:lower) }
    type { @object.class.name.pluralize.camelize(:lower) }

    attribute :resource_type do
      @_type
    end
  end
end
