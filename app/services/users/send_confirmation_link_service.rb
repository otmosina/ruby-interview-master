# frozen_string_literal: true

module Users
    class SendConfirmationLinkService
      def call(params)
        # должны сделать пометку в модели о том что ссылка отправлена
        # сформировать письмо 
        # confirmation URL where is placed?
        # вызвать Mailer с нужными параметрами

        # каждый из  этих шагов  нужно оборачивать  в монаду и  описывать ошибку
        # все кроме результирующего  шага второй ветвью будут возвращать None
        # последняя монада отдает  Success

        email = params.fetch(:email)

        emailer = params.fetch(:emailer)
        user = EmailCredential.find_by_email(email).user

        #return Failure('Too Much Requests') if user.email_credential.is_confirmation_request_has_expire?

        title = "Confirmation Link"
        # MAGIC_LINK where should be placed?
        magic_link = "https://example.com?token=%s"
        confirmation_url =  magic_link % user.token

        email_result = emailer.with(to: email, confirmation_url: confirmation_url).confirmation_email.deliver_now
        #result = EmailService.new.call(params)
        ConfirmationRequest.create(email: email, confirmation_sent_at: DateTime.now)
        #user.email_credential.mark_sent_confirmation!

        return nil
      end
    end
  end
  