# frozen_string_literal: true

class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      return scope.none if user.nil?
      return scope.all if user.admin?

      scope.joins(:roles).where(roles: { user_id: user })
    end
  end

  def update?
    user.try(:admin?) || record.has_member?(user)
  end

  def show?
    user.try(:admin?) || record.has_member?(user)
  end
end
