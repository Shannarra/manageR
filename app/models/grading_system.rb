class GradingSystem < ApplicationRecord
  before_save :autogenerate_possible_grades

  enum direction: {
         nonlinear: 3, # e.g. Danish system
         positive: 2,  # 2..6 -> + (Eastern Europe)
         negative: 1,  # 5..1 -> - (Central Europe)
         unknown: 0
       }

  validates :name,
            presence: true

  validates :direction,
            presence: { message: 'must be provided' },
            inclusion: { in: :direction }

  validates :institution_id,
            presence: { message: 'must be provided' }

  validates :possible_grades,
            presence: { message: 'was not generated properly, please contact tech support!' },
            if: %i[ positive? negative? ]

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at
       description
       direction
       end_grade
       id
       institution_id
       name
       possible_grades
       start_grade
       step
       updated_at
     ]
  end

  private
  def autogenerate_possible_grades
    return self if nonlinear? || unknown? # cannot autogenerate grades for non-linear or unknown systems Sadeg

    grades = if positive?
               start_grade.step(by: step)
             else
               end_grade.step(by: -step)
             end.take(end_grade - 1)

    self.possible_grades = grades.join(',')
  end
end
