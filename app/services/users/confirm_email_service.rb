# frozen_string_literal: true

module Users
  class ConfirmEmailService
    def call(params)
      token = params.fetch(:token)
      User.find_by_token(token).email_credential.confirm_credential!
      return nil
    end
  end
end
  