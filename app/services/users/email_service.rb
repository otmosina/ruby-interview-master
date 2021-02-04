# frozen_string_literal: true

module Users
    class EmailService
        #extend Dry::Validation::Contract
        #Schema = schema do
        #  required(:to).value(format?: URI::MailTo::EMAIL_REGEXP)
        #  required(:body).filled
        #end

        #option :to
        #option :body
        #option :emailer, default: -> { UserMailer }

        def call(params={})
            confirmation_url = params.fetch(:confirmation_url)
            to = params.fetch(:to)
            emailer = params.fetch(:emailer)
            email_result = emailer.with(to: to, confirmation_url: confirmation_url).confirmation_email.deliver_now#.deliver_later
            #raise Net::SMTPServerBusy
            return email_result
            #if email_result
            #  Success.new(email_result)
            #else
            #  Failure('email error')
            #end
        end
    end
end
  
  