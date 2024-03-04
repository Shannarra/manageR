class Institution < ApplicationRecord
  has_many :users
  has_many :i_classes

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at id location name updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[users]
  end
end
