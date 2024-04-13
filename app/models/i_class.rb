class IClass < ApplicationRecord
  belongs_to :institution
  has_many :subjects

  validates :name, presence: true
  validates :year, presence: true
  validates :description, presence: true

  validate :ensure_class_uniqueness

  scope :for, ->(institution) { where(institution: institution) }

  def self.ransackable_attributes(auth_object = nil)
   %w[created_at description id institution_id name updated_at year]
  end

  private
  def ensure_class_uniqueness
    classes = IClass
                .where(institution: self.institution.id)

    klass = classes.find do |c|
      c.name == self.name &&
        c.institution == self.institution &&
        c.year == self.year
    end

    if klass
      errors.add(:base, "Class with that name already exists for #{self.institution.name}")
      errors.add(:name, 'should be unique for every year')
      errors.add(:year, 'should be different for classes with the same name')

      return false
    end

    true
  end
end
