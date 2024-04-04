class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.string :name
      t.integer :creation_scope, default: 0, null: false
      t.references :institution, null: false, foreign_key: true
      t.references :by, null: true

      t.timestamps
    end

    add_foreign_key :reports, :users, column: :by_id
  end
end
