class UserMailer < ApplicationMailer
    default from: 'notification@example.com'

    def confirmation_email
        to = params[:to]
        subject = "Confirmation email"
        @confirmation_url = params[:confirmation_url]

        mail(to:to, subject:subject)
    end

end
