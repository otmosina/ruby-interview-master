# frozen_string_literal: true

module Users
    class ConfirmationEmailService
      def call(params)
        #user_params = build_user_params
        #user_params.merge!(build_email_credential_params(params))
        token = params.fetch(:token)
        original_token = params.fetch(:original_token)
        #User.create(user_params)
        if token == original_token#confirm
            return nil
        else
            return :error
        end
      end
  
      private

      def confirm_token user
        user.email_credential.change_state!
      end
  
      def build_user_params
        {}
      end
  
      #def build_email_credential_params(params)
      #  email_credential_params = {
      #    email: params.fetch(:email),
      #    password: params.fetch(:password)
      #  }
      #  {email_credential_attributes: email_credential_params}
      #end
    end
  end
  