# frozen_string_literal: true

module Api::V1
  class UsersController < ::Api::V1::ApplicationController
    skip_before_action :authorize_access_request!, only: [:create]#, :confirmation_email]

    def create
      result = resolve_action.new(context: {current_user: current_user, emailer: UserMailer}).call(params.to_unsafe_h)

      if result.success?
        responds_with_resource(result.value!, status: 201)
      else
        handle_failure(result)
      end
    end

    def confirmation_email
      result = resolve_action.new(context: {current_user: current_user}).call(params.to_unsafe_h)

      if result.success?
        responds_with_resource(result.value!, status: 201)
      else
        handle_failure(result)
      end
    end

    def resend_confirmation_link
      result = resolve_action.new(context: {current_user: current_user, emailer: UserMailer}).call(params.to_unsafe_h)

      if result.success?
        responds_with_resource(result.value!, status: 201)
      else
        handle_failure(result)
      end
    end    

  end
end
