class TicketPolicy < ApplicationPolicy
  def show?
    user.try(:admin)  || record.project.roles.exists?(user_id: user)
  end
end
