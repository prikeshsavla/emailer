# frozen_string_literal: true

class EventResolver
  def initialize(mailer: EventMailer)
    @mailer = mailer
  end

  def notify(event_label, message_detail)
    template = EmailTemplate.find_by!(label: event_label)
    message = EmailMessage.new({ to: message_detail[:to],
                                 subject: template.subject, body: template.body, custom_fields: template.custom_fields, fields: message_detail[:fields] })
    if message.valid?
      mailer.notify(message).deliver
    else
      raise message.errors.to_a.join(', ')
    end
  end

  attr_reader :mailer
end
