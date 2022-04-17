class ConfirmationMailer < ApplicationMailer
  def subscription(subscriber)
    @subscriber = subscriber
    mail to: subscriber.email, subject: I18n.t("activerecord.mailer.subject")
  end
end
