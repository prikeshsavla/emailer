# frozen_string_literal: true

class EventMailer < ApplicationMailer
  def notify(email)
    subject = 'Welcome to My Awesome Site'
    mail(to: email, subject:)
  end
end
