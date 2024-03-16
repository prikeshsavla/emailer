# frozen_string_literal: true

RSpec.describe EventResolver do
  let(:event_mailer_mock) { class_double(EventMailer) }
  let(:attributes) { { subject: 'Test event subject', body: 'Test event body', to: 'test@example.com' } }
  let(:message) { instance_double(Mail::Message) }

  before do
    create(:email_template, label: 'event_name', subject: 'Test event subject', body: 'Test event body',
                            custom_fields: %w[first_name amount])
    create(:email_template, label: 'event_no_fields', subject: 'Test event subject', body: 'Test event body')
  end

  describe 'accepts an event label' do
    before do
      allow(message).to receive(:deliver)
    end

    describe 'with fields' do
      it 'triggers an email', :aggregate_failures do
        fields = { first_name: 'John', amount: 20 }
        allow(event_mailer_mock).to receive(:notify).with(having_attributes(attributes.merge({ fields: })))
                                                    .and_return(message)
        described_class.new(mailer: event_mailer_mock).notify('event_name', { to: 'test@example.com', fields: })
        expect(message).to have_received(:deliver)
      end

      it 'throws error for missing values' do
        fields = { first_name: 'John' }
        subject = described_class.new(mailer: event_mailer_mock)
        expect  do
          subject.notify('event_name', { to: 'test@example.com', fields: })
        end.to raise_error('Fields must have amount')
      end

      it 'throws error when no fields are sent' do
        subject = described_class.new(mailer: event_mailer_mock)
        expect  do
          subject.notify('event_name', { to: 'test@example.com' })
        end.to raise_error('Fields must have first_name, amount')
      end
    end

    it 'triggers mailer without any fields', :aggregate_failures do
      allow(event_mailer_mock).to receive(:notify).with(having_attributes(attributes)).and_return(message)
      subject = described_class.new(mailer: event_mailer_mock)
      subject.notify('event_no_fields', { to: 'test@example.com' })
      expect(message).to have_received(:deliver)
    end

    it 'throws error on requesting a unavailable event' do
      subject = described_class.new(mailer: event_mailer_mock)
      expect do
        subject.notify('missing_event', { to: 'test@example.com' })
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
