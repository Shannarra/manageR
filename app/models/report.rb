class Report < ApplicationRecord
  belongs_to :institution
  belongs_to :by, class_name: 'User'

  mount_uploader :file, ReportUploader

  enum creation_scope: {
         institution: 3,
         classes: 2,
         subjects: 1,
         unknown: 0,
       }

  enum state: {
         completed: 2,
         in_progress: 1,
         requested: 0,
       }

  enum format: {
         pdf: 2,
         json: 1,
         csv: 0,
       }

  validates :creation_scope, presence: { message: 'must be selected' }
  validates :name, presence: { message: 'must be provided' }

  scope :requested, -> { where(state: :requested) }
  scope :for_institution, ->(institution) { where(institution: institution) }
end
