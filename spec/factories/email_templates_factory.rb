# frozen_string_literal: true

FactoryBot.define do
  factory :email_template do
    name { 'Custom event' }
    subject { 'Email Subject' }
    label { 'custom_event' }
    body { 'Test email template' }
  end
end
