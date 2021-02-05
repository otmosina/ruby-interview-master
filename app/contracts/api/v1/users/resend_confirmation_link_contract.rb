
# frozen_string_literal: true
module Api::V1
    module Users
      class ResendConfirmationLinkContract < ApplicationContract
        params do
          required(:email).filled(:string)
          required(:user_id).filled(:integer)
          required(:emailer).value(Types::Emailer)
        end

        rule(:email) do
          if ConfirmationRequest.last_by_email(value)&.is_confirmation_request_has_expire?
            base.failure('Too Much Requests')
          end
        end        
      end
    end
  end