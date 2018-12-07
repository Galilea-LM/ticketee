class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  scope :excluding_archived, lambda {where(archived_at: nil)}
  def archive
    self.update(archived_at: Time.now)
  end
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
   def to_s
    "#{email} (#{admin? ? "Admin" : "User"})"
   end
   def active_for_authentication?
     super && archived_at.nil? super: :archived
   end
end
