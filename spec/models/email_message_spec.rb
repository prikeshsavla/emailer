require 'rails_helper'

RSpec.describe EmailMessage do
  it { is_expected.to validate_presence_of(:to) }
  it { is_expected.to validate_presence_of(:subject) }
  it { is_expected.to validate_presence_of(:body) }
end
