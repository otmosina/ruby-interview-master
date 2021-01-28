# frozen_string_literal: true

module Api::V1
    module Users
      class ConfirmationEmailContract < ApplicationContract
        params do
          required(:token).filled(:string)
          required(:original_token).filled(:string)
          required(:user_id).filled(:integer)
          #required(:password).filled(:string)
        end
      end
    end
  end
  