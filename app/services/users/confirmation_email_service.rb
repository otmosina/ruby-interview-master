# frozen_string_literal: true

module Users
    class ConfirmationEmailService
      def call(params)
        user_id = params.fetch(:user_id)
        user = User.find_by_id(user_id)
        confirm_token(user)
        return nil
        
        #token = params.fetch(:token)
        #user_id = params.fetch(:user_id)
        #user = User.find_by_id(user_id)
        #original_token = user.token#params.fetch(:original_token)
        ##User.create(user_params)
        ## вот это надо выносить в контракт
        #if token == original_token#confirm
        #    confirm_token(current_user)
        #    return nil
        #else
        #    puts "NOT MATCH TOKENNNNNNNN AAAAAAAA"
        #    return nil#:error
        #end

      end
  
      private

      def confirm_token user
        user.email_credential.confirm_credential!
      end
  
      def build_user_params
        {}
      end
    end
  end
  