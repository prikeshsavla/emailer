# frozen_string_literal: true

FactoryBot.define do
  factory :email_message do
    subject { 'Email Subject' }
    to { 'email@example.com' }
    body { 'Test email template' }
  end
end
