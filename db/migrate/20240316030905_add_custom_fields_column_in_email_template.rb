# frozen_string_literal: true

class AddCustomFieldsColumnInEmailTemplate < ActiveRecord::Migration[7.1]
  def change
    add_column :email_templates, :custom_fields, :jsonb, null: false, default: ''
  end
end
