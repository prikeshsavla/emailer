# frozen_string_literal: true

class EmailMessage
  include ActiveModel::Model

  attr_accessor :to, :subject, :body

  validates :to, :subject, :body, presence: true
end
