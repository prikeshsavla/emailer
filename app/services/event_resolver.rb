# frozen_string_literal: true

class EventResolver
  def initialize(mailer: EventMailer)
    @mailer = mailer
  end

  def notify(event_label, params)
    template = EmailTemplate.find_by(label: event_label)
    message = EmailMessage.new({ to: params[:to], subject: template.subject, body: template.body })
    mailer.notify(message).deliver
  end

  attr_reader :mailer
end
