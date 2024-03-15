# frozen_string_literal: true

class EventMailer < ApplicationMailer
  def notify(email)
    @email = email
    mail(to: email.to, subject: email.populated_subject)
  end
end
