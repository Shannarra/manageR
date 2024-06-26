class Attendance < ApplicationRecord
  belongs_to :i_class
  belongs_to :teacher, class_name: "User"
  belongs_to :student, class_name: "User", dependent: :destroy

  enum attendance_type: {
         present: 2,
         absent: 1,
         unknown: 0,
       }

  validates :attendance_type, presence: { message: "must exist" }#, inclusion: { in: :attendance_type }, unless: :partial

  validates :i_class, presence: { message: "must exist" }
  validate :teacher

  scope :taking_types, -> { %i[ present absent ] }
  scope :partial, -> { where(partial: true) }
  scope :daily, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }
  scope :per_class, -> { daily.joins(:i_class).group_by {|att| att.i_class_id } }
  scope :for_institution, ->(institution) { daily.joins(:i_class).where(i_class: IClass.for(institution)) }
  scope :monthly, -> { where(created_at: 1.months.ago..Date.today) }
  scope :yearly, -> { where(created_at: 1.years.ago..Date.today) }
end
