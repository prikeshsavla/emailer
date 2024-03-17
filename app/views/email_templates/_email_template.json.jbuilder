# frozen_string_literal: true

json.extract! email_template, :id, :name, :label, :body, :subject, :custom_fields, :created_at, :updated_at
json.url email_template_url(email_template, format: :json)
