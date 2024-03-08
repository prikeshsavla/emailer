# frozen_string_literal: true

require "rails_helper"

RSpec.describe EventMailer, type: :mailer do
  describe "notify" do
    let(:mail) { EventMailer.notify('test@example.com') }

    it "renders the headers" do
      expect(mail.subject).to eq("Welcome to My Awesome Site")
      expect(mail.to).to eq(["test@example.com"])
      expect(mail.from).to eq(["no-reply@example.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Welcome to example.com")
    end
  end
end
