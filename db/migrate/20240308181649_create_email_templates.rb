# frozen_string_literal: true

class CreateEmailTemplates < ActiveRecord::Migration[7.1]
  def change
    create_table :email_templates do |t|
      t.string :name
      t.string :label
      t.text :body

      t.timestamps
    end
  end
end
