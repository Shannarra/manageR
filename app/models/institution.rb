class Institution < ApplicationRecord
  has_many :users
  has_many :i_classes
  has_one :grading_system
  has_many :subjects, through: :i_classes

  validates :name, presence: true
  validates :location, presence: true
  validates :code, presence: true

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at id location name updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[users]
  end
end
