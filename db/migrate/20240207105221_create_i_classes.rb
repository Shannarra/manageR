class CreateIClasses < ActiveRecord::Migration[7.0]
  def change
    create_table :i_classes do |t|
      t.string :name
      t.integer :year
      t.references :institution, null: false, foreign_key: true

      t.timestamps
    end
  end
end
