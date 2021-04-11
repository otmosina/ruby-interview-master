# frozen_string_literal: true

module Users
    class SendConfirmationLinkService
      def initialize emailer
        @emailer = emailer
      end
      def call(params)
        email = params.fetch(:email)
        
        user = EmailCredential.find_by_email(email).user
        email_result = @emailer.with(to: email, confirmation_url: user.confirmation_link).confirmation_email.deliver_later

        ConfirmationRequest.create(email: email, confirmation_sent_at: DateTime.now)

        return nil
      end
    end
  end
  