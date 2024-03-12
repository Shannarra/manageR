class CreateGrades < ActiveRecord::Migration[7.0]
  def change
    create_table :grades do |t|
      t.integer :value
      t.string :reason
      t.integer :source_type
      t.references :assignee, null: false
      t.references :assigned_by, null: false
      t.references :source, null: true

      t.timestamps
    end

    add_foreign_key :grades, :users, column: :assignee_id
    add_foreign_key :grades, :users, column: :assigned_by_id
    add_foreign_key :grades, :exams, column: :source_id
  end
end
