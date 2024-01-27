class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # Signing up for the system is disabled.
  # Only system/institution admins can create new users
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum access_type: {
         admin: 5,
         director: 4,
         teacher: 3,
         student: 2,
         unassigned: 0,
       }

  validates :access_type, presence: true, inclusion: { in: :access_type }
end
