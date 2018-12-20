# frozen_string_literal: true

class Ticket < ApplicationRecord
  belongs_to :project
  belongs_to :author, class_name: 'User'
  validates :name, :description, presence: true
  validates :description, length: { maximum: 1000 }
end
