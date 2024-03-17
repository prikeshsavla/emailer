# frozen_string_literal: true

class EmailTemplate < ApplicationRecord
  validates :name, :label, :body, :subject, presence: true

  validate :validate_custom_fields_format, if: :custom_fields?

  def parsed_custom_fields
    JSON.parse custom_fields if custom_fields.present?
  end

  private

  def validate_custom_fields_format
    errors.add(:custom_fields, 'invalid format') unless valid_custom_fields?
  rescue StandardError
    errors.add(:custom_fields, 'invalid format')
  end

  def valid_custom_fields?
    parsed_fields = JSON.parse custom_fields
    parsed_fields.is_a?(Array) && parsed_fields.any? && parsed_fields.uniq.length == parsed_fields.length
  end
end
