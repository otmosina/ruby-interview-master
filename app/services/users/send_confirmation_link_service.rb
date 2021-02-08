# frozen_string_literal: true

module Users
    class SendConfirmationLinkService
      def initialize emailer
        @emailer = emailer
        
      end
      def call(params)
        email = params.fetch(:email)
        
        user = EmailCredential.find_by_email(email).user

        # MAGIC_LINK where should be placed?
        magic_link = "https://example.com?token=%s"
        confirmation_url =  magic_link % user.token
        email_result = @emailer.with(to: email, confirmation_url: confirmation_url).confirmation_email.deliver_now

        ConfirmationRequest.create(email: email, confirmation_sent_at: DateTime.now)

        return nil
      end
    end
  end
  