class AddPartialAttendances < ActiveRecord::Migration[7.0]
  def change
    add_column :attendances, :partial, :boolean, default: false
  end
end
