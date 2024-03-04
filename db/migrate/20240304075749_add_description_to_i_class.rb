class AddDescriptionToIClass < ActiveRecord::Migration[7.0]
  def change
    add_column :i_classes, :description, :string, default: "Please add description"
  end
end
