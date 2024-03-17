# frozen_string_literal: true

class EventResolver
  def initialize(mailer: EventMailer)
    @mailer = mailer
  end

  def notify(event_label, message_detail)
    template = EmailTemplate.find_by!(label: event_label)
    message = build_message(message_detail, template)
    raise message.errors.to_a.join(', ') if message.invalid?

    mailer.notify(message).deliver
  end

  private

  def build_message(message_detail, template)
    EmailMessage.new({ to: message_detail[:to],
                       subject: template.subject,
                       body: template.body,
                       custom_fields: template.parsed_custom_fields,
                       fields: message_detail[:fields] })
  end

  attr_reader :mailer
end
