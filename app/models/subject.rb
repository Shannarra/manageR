class Subject < ApplicationRecord
  belongs_to :user
  belongs_to :i_class

  validates :name,
            presence: true
  validates :year,
            presence: true
  validates :description,
            presence: true

  def teacher
    user
  end

  def klass
    i_class
  end
end
