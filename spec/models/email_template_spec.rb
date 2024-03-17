# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmailTemplate do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:label) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_presence_of(:subject) }

  it 'accepts only right format of json array' do
    subject = build(:email_template, custom_fields: '["abc"]')
    expect(subject).to be_valid
  end

  it 'rejects incorrect format of json array' do
    subject = build(:email_template, custom_fields: '{"abc": "abc"}')
    expect(subject).not_to be_valid
  end

  it 'rejects duplicate entries in array' do
    subject = build(:email_template, custom_fields: '["abc", "abc"]')
    expect(subject).not_to be_valid
  end

  it 'rejects incorrect format of json' do
    subject = build(:email_template, custom_fields: '{"')
    expect(subject).not_to be_valid
  end
end
