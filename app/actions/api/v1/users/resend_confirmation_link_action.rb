# frozen_string_literal: true

module Api::V1
    module Users
      class ResendConfirmationLinkAction < ::Api::V1::BaseAction
        def call(input)          
          params = yield deserialize(input)
          params[:user_id] = @current_user&.id
          return Failure(errors: 'Too Much Requests') if @current_user.email_credential.is_confirmation_request_has_expire?
          params = yield validate(params)
          params[:emailer] = UserMailer
          create(params)
        end
  
        private
  
        def create(input)
          # а вот тут мы описываем возможные ошибки от  каждой монады внутри сервиса
          Try(active_record_common_errors) do
            ::Users::SendConfirmationLinkService.new.call(input)
            # по идее в сервис можно передать клиент для оправки письма который работает с параметрами to message и так далее
          end.to_result
        end
      end
    end
  end
  