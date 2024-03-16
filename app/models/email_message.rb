# frozen_string_literal: true

class EmailMessage
  include ActiveModel::Model

  attr_accessor :to, :subject, :body, :fields, :custom_fields

  validates :to, :subject, :body, presence: true
  validate :validate_fields, if: :custom_fields?

  def validate_fields
    if fields.nil?
      errors.add :fields, "must have #{custom_fields.join(', ')}" 
    else
      missing_fields = custom_fields - fields.stringify_keys.keys
      errors.add :fields, "must have #{missing_fields.join(', ')}" if missing_fields.any?
    end
  end

  def populated_subject
    populate(subject)
  end

  def populated_body
    populate(body)
  end

  def custom_fields?
    custom_fields.present?
  end

  private

  def populate(string)
    string.gsub('{{', '%{').gsub('}}', '}') % fields
  end

  # string = "message {{abc}}"
  # string = string.gsub("{{", "%{").gsub("}}", "}")
  # string % {abc: "red"}
end
