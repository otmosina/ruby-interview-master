
# frozen_string_literal: true
module Api::V1
    module Users
      class ResendConfirmationLinkContract < ApplicationContract
        params do
          #required(:email).filled(:string)
          # и вот тут-то стало понятно почему надо реализовавывать попытки отсылки сообшения в отдельной сущности
          # оно будет иискать отсылки в emailRequests а не по пользователю

          required(:user_id).filled(:integer)
          required(:emailer).value(Types::Emailer)
        end

        rule(:user_id) do
          base.failure('Too Much Requests') if User.find_by_id(value).email_credential.is_confirmation_request_has_expire?
        end        
      end
    end
  end