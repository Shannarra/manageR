class AddBioToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :bio, :string, default: "Tell us something about yourself"
  end
end
