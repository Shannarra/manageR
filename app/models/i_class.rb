class IClass < ApplicationRecord
  belongs_to :institution
  has_many :subjects

  validates :name, presence: true
  validates :year, presence: true
  validates :description, presence: true

  scope :for, ->(institution) { where(institution: institution) }

  def self.ransackable_attributes(auth_object = nil)
   %w[created_at description id institution_id name updated_at year]
  end
end
