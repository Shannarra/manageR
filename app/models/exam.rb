class Exam < ApplicationRecord
  belongs_to :subject
  belongs_to :user
  has_many :users, through: :subject

  enum exam_type: {
         physical: 2,
         online: 1,
         unknown: 0,
       }

  mount_uploader :attachment, ExamAttachmentUploader

  validates :name, presence: true, length: { maximum: 50 }
  validates :exam_type, presence: true, inclusion: { in: :exam_type }
  validate :subject
  validate :user

  validates :schedule,
            presence: {
              message: 'for the exam must be provided'
            },
            inclusion: {
              in: (1.day.from_now..),
              message: 'in the future must be provided'
            }

  scope :creation_types, -> { %i[ physical online ] }
  scope :upcoming, -> { where(schedule: Date.today.beginning_of_day..) }
  scope :user_exams, ->(user) { where(subject: user.i_class.subjects.pluck(:id)) }
end
