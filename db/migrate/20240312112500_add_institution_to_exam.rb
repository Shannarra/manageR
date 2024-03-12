class AddInstitutionToExam < ActiveRecord::Migration[7.0]
  def change
    add_column :exams, :institution_id, :integer

    add_foreign_key :exams, :institutions, column: :institution_id
  end
end
