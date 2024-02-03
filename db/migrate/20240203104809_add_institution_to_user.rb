class AddInstitutionToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :institution, null: false, foreign_key: true
  end
end
