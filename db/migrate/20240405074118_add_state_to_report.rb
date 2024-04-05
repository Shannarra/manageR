class AddStateToReport < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :state, :integer, default: 0
  end
end
