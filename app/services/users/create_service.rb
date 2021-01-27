# frozen_string_literal: true

module Users
  class CreateService
    def call(params)
      user_params = build_user_params
      user_params.merge!(build_email_credential_params(params))

      User.create(user_params)
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
