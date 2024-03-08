class Grade < ApplicationRecord
  belongs_to :assignee, class_name: 'User'
  belongs_to :assigned_by, class_name: 'User'
  belongs_to :source, class_name: 'Exam', required: false

  enum source_type: {
         exam: 2,
         regular: 1,
         unknown: 0
       }

  validates :source_type, presence: true, inclusion: { in: :source_type }

  validate :assignee, if: :exam?
  validate :assigned_by, if: :exam?
  validates :source, presence: true, if: :exam?
  validate :ensure_valid

  scope :types, ->() { %i[exam regular] }
  scope :for_institution, ->(institution) {
    where(assigned_by: institution.user_ids,
          assignee_id: institution.user_ids)
  }
  scope :personal, ->(user_id) {
    where(assignee_id: user_id)
  }

  private
  def ensure_valid
    unless assigned_by.institution.id == assignee.institution.id
      # This should never be happening, but IF it does we should
      # encourage contacting dev/support team
      errors.add(:base, 'please, show this message to support ASAP')
      errors.add(:assignee, 'and assigned_by must be from the same institution')
      errors.add(:assigned_by, 'and assignee must be from the same institution')
      return false
    end

    grades = assigned_by.institution.grading_system.possible_grades
    items = grades.tr(' ','').split(',')

    unless items.include? value.to_s
      errors.add(:value, "must be one of #{grades}")
      return false
    end

    true
  end
end
