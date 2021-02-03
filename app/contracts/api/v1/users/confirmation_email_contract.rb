# frozen_string_literal: true

module Api::V1
    module Users
      class ConfirmationEmailContract < ApplicationContract
        params do
          required(:token).filled(:string)
          required(:original_token).filled(:string)
          required(:user_id).filled(:integer)
        end

        rule(:token, :original_token) do
          base.failure('Tokens not matched') if values[:token] != values[:original_token]        
        end
      end
    end
  end
  