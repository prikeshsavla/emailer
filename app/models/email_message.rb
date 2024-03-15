# frozen_string_literal: true

class EmailMessage
  include ActiveModel::Model

  attr_accessor :to, :subject, :body, :params

  validates :to, :subject, :body, presence: true

  def populated_subject
    populate(subject)
  end

  def populated_body
    populate(body)
  end

  private

  def populate(string)
    string.gsub('{{', '%{').gsub('}}', '}') % params
  end

  # string = "message {{abc}}"
  # string = string.gsub("{{", "%{").gsub("}}", "}")
  # string % {abc: "red"}
end
