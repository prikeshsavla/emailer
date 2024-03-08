# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmailTemplate do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:label) }
  it { is_expected.to validate_presence_of(:body) }
end
