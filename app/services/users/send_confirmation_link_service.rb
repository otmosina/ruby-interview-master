# frozen_string_literal: true

module Users
  class SendConfirmationLinkService
    def initialize(emailer)
      @emailer = emailer
    end

    def call(params)
      email = params.fetch(:email)
      request = ConfirmationRequest.new(email: email, confirmation_sent_at: DateTime.now)
      email_result = @emailer.with(to: email, confirmation_url: request.confirmation_link).confirmation_email.deliver_later
      request.save!
 
      nil
    end
  end
  end
