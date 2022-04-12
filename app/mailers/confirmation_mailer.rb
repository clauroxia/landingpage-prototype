class ConfirmationMailer < ApplicationMailer
  def subscription(subscriber)
    @subscriber = subscriber
    mail to: subscriber.email, subject: 'Confirmation'
  end
end
