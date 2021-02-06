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
        rule(:token) do
          #byebug
         if ConfirmationRequest.find_by_email( User.find_by_token(values[:token])&.email_credential&.email).present? && !ConfirmationRequest.find_by_email(User.find_by_token(values[:token])&.email_credential&.email )&.is_confirmation_link_has_expire? 
            base.failure('Confirmation link already expire')
          end    
        end        

      end
    end
  end
  