# frozen_string_literal: true

class Role < ApplicationRecord
  belongs_to :user
  belongs_to :project
  
  def roles
    hash = {}
    Role.available_roles.each do |role|
      hash[role.titleize] = role
    end
    hash
  end

end
