class Attendance < ApplicationRecord
  belongs_to :i_class
  has_one :teacher, class_name: "User"
  has_one :student, class_name: "User"

  enum attendance_type: {
         present: 2,
         absent: 1,
         unknown: 0,
       }

  validates :attendance_type, presence: true, inclusion: {
              in: :attendance_type
            }
  scope :taking_types, -> { %i[ present absent ] }
end
