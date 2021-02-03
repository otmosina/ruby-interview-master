# frozen_string_literal: true

module Users
  class CreateService
    def call(params)
      user_params = build_user_params
      user_params.merge!(build_email_credential_params(params))

      user = User.create(user_params)
      user
      
      #emailer = params.fetch(:emailer)
      #email_result = emailer.with(to: "otmosina@gmail.com", confirmation_url: "www.www.ru").confirmation_email.deliver_now#.deliver_later
      #if true#email_result is Success
      #  user.email_credential.mark_sent_confirmation!
      #end
      #confirmation_url = params.fetch(:confirmation_url)
      #to = params.fetch(:to)
      #emailer = params.fetch(:emailer)
      #email_result = emailer.with(to: to, confirmation_url: confirmation_url).confirmation_email.deliver_now#.deliver_later
      #return email_result

    end

    private

    def build_user_params
      {}
    end

    def build_email_credential_params(params)
      email_credential_params = {
        email: params.fetch(:email),
        password: params.fetch(:password)
      }

      {email_credential_attributes: email_credential_params}
    end
  end
end
