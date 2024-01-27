class AddAccessTypeToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :access_type, :integer, default: 0
  end
end
