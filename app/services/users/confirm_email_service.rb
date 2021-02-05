# frozen_string_literal: true

module Users
  class ConfirmEmailService
    def call(params)
      token = params.fetch(:token)
      u = User.find_by_token(token)
      u.email_credential.confirm_credential!
      return
    end
  end
end
  