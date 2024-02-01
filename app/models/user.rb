class User < ApplicationRecord
  # Signing up for the system is disabled.
  # Only system/institution admins can create new users, BUT
  # :registerable needs to stay here due to the need for edit_registration
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum access_type: {
         admin: 5,
         director: 4,
         teacher: 3,
         student: 2,
         unassigned: 0,
       }

  mount_uploader :image, ImageUploader
  
  validates :access_type, presence: true, inclusion: { in: :access_type }

  scope :users_visible_to_me, ->(access_types) { where(access_type: access_types)}

  scope :access_visible_to, ->(user) {
    visible = %w[student]
    visible << %w[teacher director] if user.teacher? || user.director? || user.admin?
    visible << 'admin' if user.admin?

    visible.flatten
  }

  def has_elevated_privileges?
    admin? || director?
  end
end
