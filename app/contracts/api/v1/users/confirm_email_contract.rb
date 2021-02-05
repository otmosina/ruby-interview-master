# frozen_string_literal: true

module Api::V1
    module Users
      class ConfirmEmailContract < ApplicationContract
        params do
          required(:token).filled(:string)
        end

        rule(:token) do
          base.failure('Tokens not matched') unless User.find_by_token(values[:token])       
        end
      end
    end
  end
  