# frozen_string_literal: true

RSpec.describe EventResolver do
  let(:event_mailer_mock) { class_double(EventMailer) }
  let(:message) { instance_double(Mail::Message) }

  describe 'accepts an event label' do
    before do
      attributes = { subject: 'Test event subject', body: 'Test event body', to: 'test@example.com' }
      allow(message).to receive(:deliver)
      allow(event_mailer_mock).to receive(:notify).with(having_attributes(attributes)).and_return(message)
    end

    it 'triggers mailer with correct params', :aggregate_failures do
      create(:email_template, label: 'event_name', subject: 'Test event subject', body: 'Test event body')

      described_class.new(mailer: event_mailer_mock).notify('event_name', { to: 'test@example.com' })

      expect(event_mailer_mock).to have_received(:notify)
      expect(message).to have_received(:deliver)
    end

    # it 'and fails to find event' do
    #   # TODO
    # end
  end
end
