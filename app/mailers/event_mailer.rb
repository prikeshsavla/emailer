# frozen_string_literal: true

class EventMailer < ApplicationMailer
  def notify(email)
    mail(to: email, subject: 'Welcome to My Awesome Site')
  end
end
