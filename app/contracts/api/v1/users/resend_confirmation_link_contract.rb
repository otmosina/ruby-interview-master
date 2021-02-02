
# frozen_string_literal: true

module Api::V1
    module Users
      class ResendConfirmationLinkContract < ApplicationContract
        params do
          required(:token).filled(:string)
          required(:original_token).filled(:string)
          required(:user_id).filled(:integer)
          #required(:password).filled(:string)
        end
      end
    end
  end
  #https://www.travelpayouts.com/confirmation?token=0a5263bc021796903d2877b0fbd95cf2&utm_source=email
  #Логинит на сайт 