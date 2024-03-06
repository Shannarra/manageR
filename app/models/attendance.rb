class Attendance < ApplicationRecord
  belongs_to :i_class
  has_one :teacher, class_name: "User"
  has_one :student, class_name: "User"

  enum attendance_type: {
         present: 2,
         absent: 1,
         unknown: 0,
       }

  validates :attendance_type, presence: { message: "must exist" }, inclusion: {
              in: :attendance_type
            }, unless: :partial

  validates :i_class, presence: { message: "must exist" }
  validate :teacher
  validates :student, presence: true, unless: :partial
  validate :partial_items, if: :partial

  scope :taking_types, -> { %i[ present absent ] }
  scope :partial, -> { where(partial: true) }
  scope :daily, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }
  scope :per_class, -> { daily.joins(:i_class).group_by {|att| att.i_class_id } }

  def partial_items; end
end
