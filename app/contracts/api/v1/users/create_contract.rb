# frozen_string_literal: true

module Api::V1
  module Users
    class CreateContract < ApplicationContract
      params do
        required(:email).filled(:string)
        required(:password).filled(:string)
      end
    end
  end
end
