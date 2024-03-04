class IClass < ApplicationRecord
  belongs_to :institution
  has_many :subjects

  scope :for, ->(institution) { where(institution: institution) }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "institution_id", "name", "updated_at", "year"]
  end
end
