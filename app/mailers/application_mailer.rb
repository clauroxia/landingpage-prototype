# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "hello@example.com"
  layout "mailer"
end
