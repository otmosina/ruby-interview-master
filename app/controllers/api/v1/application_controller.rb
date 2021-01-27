# frozen_string_literal: true

module Api::V1
  class ApplicationController < ::ApplicationController
    include JWTSessions::RailsAuthorization

    rescue_from JWTSessions::Errors::Error, with: :not_authorized

    before_action :authorize_access_request!

    def jsonapi_class
      Hash.new { |h, k| h[k] = serializer_for_klass(k) }
    end

    private

    def not_authorized
      head 401
    end

    def current_user
      return @current_user if defined?(@current_user)
      return nil if found_token.nil?

      @current_user = ::Users::GetByPayloadService.new.call(payload)
    end

    def responds_with_errors(errors, status:)
      render jsonapi_errors: errors, status: status
    end

    def responds_with_resource(resource, status: 200, meta: nil)
      render jsonapi: resource, status: status, meta: camelize_meta(meta)
    end

    def camelize_meta(meta)
      meta&.deep_transform_keys { |key| key.to_s.camelize(:lower) }
    end

    def serializer_for_klass(klass)
      "::Api::V1::#{klass}Serializer".safe_constantize
    end

    def resolve_action
      [
        self.class.name.deconstantize,
        controller_name.camelize,
        "#{action_name}_action".classify
      ].join("::").constantize
    end

    def handle_failure(result)
      case result
      in Dry::Monads::Result::Failure(Dry::Validation::Result => validation)
        responds_with_errors(validation, status: 422)
      in Dry::Monads::Result::Failure(Hash => errors)
        responds_with_errors(errors, status: 422)
      in Dry::Monads::Result::Failure(ActiveRecord::RecordNotUnique => error)
        head 409
      end
    end
  end
end
