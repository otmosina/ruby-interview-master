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

        user_id = params.fetch(:user_id)
        user = User.find(user_id)

        #return Failure('Too Much Requests') if user.email_credential.is_confirmation_request_has_expire?

        to = user.email_credential.email
        title = "Confirmation Link"
        # MAGIC_LINK where should be placed?
        magic_link = "https://example.com?token=%s"
        confirmation_url =  magic_link % user.token
        
        params[:confirmation_url] = confirmation_url
        params[:to] = to 

        EmailService.new.call(params)
        user.email_credential.mark_sent_confirmation!

        return nil
      end
    end
  end
  