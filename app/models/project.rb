class Project < ApplicationRecord
  def has_member?(user)
    roles.exist?(user_id: user)
  end

    validates :name, presence: true
    has_many :tickets, dependent: :delete_all
    has_many :roles, dependent: :delete_all
  [:manager, :editor, :viewer].each do |role|
    define_method "has_#{role}?" do |user|
      roles.exists?(user_id: user, role: role)
    end
  end
end

