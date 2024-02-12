class IClass < ApplicationRecord
  belongs_to :institution

  scope :for, ->(institution) { where(institution: institution) }
end
