# frozen_string_literal: true

class Role < ApplicationRecord
  belongs_to :user
  belongs_to :project
end
