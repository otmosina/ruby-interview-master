# frozen_string_literal: true

module Users
  class ConfirmEmailService
    def call(params)
      token = params.fetch(:token)
      u = User.find_by_token(token)
      u.email_credential.confirm_credential!
      u.email_credential.update_attribute(:confirmed_at, DateTime.now)
      return
    end
  end
end
  