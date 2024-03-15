# frozen_string_literal: true

class EventResolver
  def initialize(mailer: EventMailer)
    @mailer = mailer
  end

  def notify(event_label, message_detail)
    template = EmailTemplate.find_by(label: event_label)
    message = EmailMessage.new({ to: message_detail[:to],
                                 subject: template.subject, body: template.body, params: message_detail[:params] })
    mailer.notify(message).deliver
  end

  attr_reader :mailer
end
