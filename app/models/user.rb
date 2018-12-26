# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :roles
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  scope :excluding_archived, -> { where(archived_at: nil) }
  def archive
    update(archived_at: Time.now)
  end

  def role_on(project)
    roles.find_by(project_id: project).try(:name)
  end

  def to_s
    "#{email} (#{admin? ? 'Admin' : 'User'})"
  end

  def active_for_authentication?
    super && archived_at.nil?
  end

  def inactive_message
    archived_at.nil? ? super : :archived
  end
end
