# frozen_string_literal: true

module Api::V1
  module Users
    class ResendConfirmationLinkContract < ApplicationContract
      params do
        required(:email).filled(:string)
      end

      rule(:email) do
        base.failure('Did not send any confirmation before') unless ConfirmationRequest.last_by_email(value).present?
        if ConfirmationRequest.last_by_email(value)&.is_confirmation_request_has_expire?
          base.failure('Too Much Requests')
        end
      end
    end
  end
  end
