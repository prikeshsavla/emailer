# frozen_string_literal: true

RSpec.describe EventResolver do
  let(:event_mailer_mock) { class_double(EventMailer) }
  let(:attributes) { { subject: 'Test event subject', body: 'Test event body', to: 'test@example.com' } }
  let(:message) { instance_double(Mail::Message) }

  before do
    create(:email_template, label: 'event_name', subject: 'Test event subject', body: 'Test event body')
  end

  describe 'accepts an event label' do
    before do
      allow(message).to receive(:deliver)
    end

    it 'triggers mailer with correct params', :aggregate_failures do
      params = { first_name: 'John', amount: 20 }
      allow(event_mailer_mock).to receive(:notify).with(having_attributes(attributes.merge({ params: })))
                                                  .and_return(message)
      described_class.new(mailer: event_mailer_mock).notify('event_name', { to: 'test@example.com', params: })
      expect(message).to have_received(:deliver)
    end

    it 'triggers mailer without any params', :aggregate_failures do
      allow(event_mailer_mock).to receive(:notify).with(having_attributes(attributes)).and_return(message)
      described_class.new(mailer: event_mailer_mock).notify('event_name', { to: 'test@example.com' })
      expect(message).to have_received(:deliver)
    end

    # it 'and fails to find event' do
    #   # TODO
    # end
  end
end
