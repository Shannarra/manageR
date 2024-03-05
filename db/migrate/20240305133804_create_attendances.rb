class CreateAttendances < ActiveRecord::Migration[7.0]
  def change
    create_table :attendances do |t|
      t.integer :attendance_type, default: 0
      t.integer :teacher_id
      t.integer :student_id
      t.references :i_class, null: false, foreign_key: true

      t.timestamps
    end
  end
end
