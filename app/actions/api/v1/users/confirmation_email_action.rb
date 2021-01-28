# frozen_string_literal: true

module Api::V1
    module Users
      class ConfirmationEmailAction < ::Api::V1::BaseAction
        def call(input)          
          params = yield deserialize(input)
          params[:user_id] = @current_user&.id
          params = yield validate(params)
          
          create(params)
        end
  
        private
  
        def create(input)
          Try(active_record_common_errors) do
            ::Users::ConfirmationEmailService.new.call(input)
          end.to_result
        end
      end
    end
  end
  