# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventMailer do
  describe 'notify' do
    let(:mail) do
      message = build(:email_message, to: 'test@example.com', subject: 'Reward for {{name}}',
                                      body: 'Hi {{name}}, You have recieved INR {{amount}}',
                                      params: { name: 'John', amount: 20 })
      described_class.notify(message)
    end

    it 'renders the headers', :aggregate_failures do
      expect(mail.subject).to eq('Reward for John')
      expect(mail.to).to eq(['test@example.com'])
      expect(mail.from).to eq(['no-reply@example.org'])
    end

    it 'sends an email on deliver' do
      assert_emails 1 do
        mail.deliver_now
      end
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi John, You have recieved INR 20')
    end
  end
end
