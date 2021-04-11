# frozen_string_literal: true

module Users
  class ConfirmEmailService
    def call(params)
      token = params.fetch(:token)
      request = ConfirmationRequest.find_by_token(token)
      #TODO: move state to ConfirmationRequest
      email_credential = EmailCredential.find_by_email(request.email)
      email_credential.confirm_credential!
      email_credential.update_attribute(:confirmed_at, DateTime.now)
      return
    end
  end
end
  