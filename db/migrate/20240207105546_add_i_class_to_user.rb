class AddIClassToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :i_class, null: false, foreign_key: true
  end
end
