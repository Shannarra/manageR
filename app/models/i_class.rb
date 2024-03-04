class IClass < ApplicationRecord
  belongs_to :institution

  scope :for, ->(institution) { where(institution: institution) }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "institution_id", "name", "updated_at", "year"]
  end
end
