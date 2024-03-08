# frozen_string_literal: true

class EmailTemplate < ApplicationRecord
    validates :name, :label, :body, presence: true
end
