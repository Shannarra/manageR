# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

# rubocop:disable Metrics/BlockLength
ActiveRecord::Schema[7.0].define(version: 2024_04_04_065611) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "attendances", force: :cascade do |t|
    t.integer "attendance_type", default: 0
    t.integer "teacher_id"
    t.integer "student_id"
    t.bigint "i_class_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "partial", default: false
    t.index ["i_class_id"], name: "index_attendances_on_i_class_id"
  end

  create_table "exams", force: :cascade do |t|
    t.integer "exam_type"
    t.date "schedule"
    t.string "name"
    t.string "attachment"
    t.bigint "subject_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.integer "institution_id"
    t.index ["subject_id"], name: "index_exams_on_subject_id"
    t.index ["user_id"], name: "index_exams_on_user_id"
  end

  create_table "grades", force: :cascade do |t|
    t.integer "value"
    t.string "reason"
    t.integer "source_type"
    t.bigint "assignee_id", null: false
    t.bigint "assigned_by_id", null: false
    t.bigint "source_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assigned_by_id"], name: "index_grades_on_assigned_by_id"
    t.index ["assignee_id"], name: "index_grades_on_assignee_id"
    t.index ["source_id"], name: "index_grades_on_source_id"
  end

  create_table "grading_systems", force: :cascade do |t|
    t.string "name"
    t.integer "start_grade"
    t.integer "end_grade"
    t.integer "step"
    t.integer "direction", default: 0
    t.string "description"
    t.string "possible_grades"
    t.bigint "institution_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_id"], name: "index_grading_systems_on_institution_id"
  end

  create_table "i_classes", force: :cascade do |t|
    t.string "name"
    t.integer "year"
    t.bigint "institution_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description", default: "Please add description"
    t.index ["institution_id"], name: "index_i_classes_on_institution_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code", default: "rR4RDEFYdpj7Th1o8AFJ"
  end

  create_table "reports", force: :cascade do |t|
    t.string "name"
    t.integer "creation_scope", default: 0, null: false
    t.bigint "institution_id", null: false
    t.bigint "by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["by_id"], name: "index_reports_on_by_id"
    t.index ["institution_id"], name: "index_reports_on_institution_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.integer "year"
    t.string "description"
    t.bigint "user_id", null: false
    t.bigint "i_class_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["i_class_id"], name: "index_subjects_on_i_class_id"
    t.index ["user_id"], name: "index_subjects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "gender"
    t.string "phone"
    t.string "image"
    t.integer "access_type", default: 0
    t.bigint "institution_id", null: false
    t.string "institution_code"
    t.bigint "i_class_id", null: false
    t.string "bio", default: "Tell us something about yourself"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["i_class_id"], name: "index_users_on_i_class_id"
    t.index ["institution_id"], name: "index_users_on_institution_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "attendances", "i_classes"
  add_foreign_key "exams", "institutions"
  add_foreign_key "exams", "subjects"
  add_foreign_key "exams", "users"
  add_foreign_key "grades", "exams", column: "source_id"
  add_foreign_key "grades", "users", column: "assigned_by_id"
  add_foreign_key "grades", "users", column: "assignee_id"
  add_foreign_key "grading_systems", "institutions"
  add_foreign_key "i_classes", "institutions"
  add_foreign_key "reports", "institutions"
  add_foreign_key "reports", "users", column: "by_id"
  add_foreign_key "subjects", "i_classes"
  add_foreign_key "subjects", "users"
  add_foreign_key "users", "i_classes"
  add_foreign_key "users", "institutions"
end
# rubocop:enable Metrics/BlockLength
