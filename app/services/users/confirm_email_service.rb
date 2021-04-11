# frozen_string_literal: true

module Users
  class ConfirmEmailService
    def call(params)
      token = params.fetch(:token)
      request = ConfirmationRequest.find_by_token(token)
      request.confirm_credential!
      return
    end
  end
end
  