class CreateGradingSystems < ActiveRecord::Migration[7.0]
  def change
    create_table :grading_systems do |t|
      t.string :name
      t.integer :start_grade
      t.integer :end_grade
      t.integer :step
      t.integer :direction, default: 0
      t.string :description
      t.string :possible_grades

      t.references :institution, null: false, foreign_key: true

      t.timestamps
    end
  end
end
