# frozen_string_literal: true

class EmailTemplate < ApplicationRecord
  validates :name, :label, :body, :subject, presence: true

  def abc
    name?
  end
end
