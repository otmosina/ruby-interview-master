
# frozen_string_literal: true
module Api::V1
    module Users
      class ResendConfirmationLinkContract < ApplicationContract
        params do
          required(:user_id).filled(:integer)
        end
        rule(:user_id) do
          base.failure('Too Much Requests') if User.find_by_id(value).email_credential.is_confirmation_request_has_expire?
        end        
      end
    end
  end
  #https://www.travelpayouts.com/confirmation?token=0a5263bc021796903d2877b0fbd95cf2&utm_source=email
  #Логинит на сайт 