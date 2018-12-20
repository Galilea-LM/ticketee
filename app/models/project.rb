# frozen_string_literal: true

class Project < ApplicationRecord
  def member?(user)
    roles.exist?(user_id: user)
  end

  validates :name, presence: true
  has_many :tickets, dependent: :delete_all
  has_many :roles, dependent: :delete_all
  %i[manager editor viewer].each do |role|
    define_method "#{role}?" do |user|
      roles.exists?(user_id: user, role: role)
    end
  end
end
