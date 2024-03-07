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

  validates_presence_of :schedule, message: "for the exam must be provided"

  scope :creation_types, -> { %i[ physical online ] }
end
