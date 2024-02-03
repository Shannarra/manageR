class AddCodeToInstitutionAndUser < ActiveRecord::Migration[7.0]
  def change
    add_column :institutions, :code, :string, default: SecureRandom.alphanumeric(20)
    add_column :users, :institution_code, :string
  end
end
