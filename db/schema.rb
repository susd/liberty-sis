# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150819164922) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "classroom_leaderships", force: :cascade do |t|
    t.integer  "employee_id"
    t.integer  "classroom_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "classroom_leaderships", ["classroom_id"], name: "index_classroom_leaderships_on_classroom_id", using: :btree
  add_index "classroom_leaderships", ["employee_id"], name: "index_classroom_leaderships_on_employee_id", using: :btree

  create_table "classroom_memberships", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "classroom_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "classroom_memberships", ["classroom_id"], name: "index_classroom_memberships_on_classroom_id", using: :btree
  add_index "classroom_memberships", ["student_id"], name: "index_classroom_memberships_on_student_id", using: :btree

  create_table "classrooms", force: :cascade do |t|
    t.string   "name"
    t.integer  "site_id"
    t.jsonb    "import_details", default: {}, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "classrooms", ["site_id"], name: "index_classrooms_on_site_id", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "employees", force: :cascade do |t|
    t.string   "type"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "sex"
    t.string   "email"
    t.date     "birthdate"
    t.date     "hired_on"
    t.integer  "years_edu",      default: 0,  null: false
    t.integer  "years_district", default: 0,  null: false
    t.string   "title"
    t.integer  "status",         default: 0,  null: false
    t.integer  "legacy_id"
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.jsonb    "import_details", default: {}, null: false
  end

  add_index "employees", ["birthdate"], name: "index_employees_on_birthdate", using: :btree
  add_index "employees", ["email"], name: "index_employees_on_email", using: :btree
  add_index "employees", ["last_name"], name: "index_employees_on_last_name", using: :btree
  add_index "employees", ["legacy_id"], name: "index_employees_on_legacy_id", using: :btree
  add_index "employees", ["type"], name: "index_employees_on_type", using: :btree

  create_table "employees_sites", id: false, force: :cascade do |t|
    t.integer "employee_id"
    t.integer "site_id"
  end

  add_index "employees_sites", ["employee_id"], name: "index_employees_sites_on_employee_id", using: :btree
  add_index "employees_sites", ["site_id"], name: "index_employees_sites_on_site_id", using: :btree

  create_table "grades", force: :cascade do |t|
    t.text     "name"
    t.float    "position"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "legacy_id",  default: 0, null: false
  end

  create_table "grading_periods", force: :cascade do |t|
    t.date     "start"
    t.date     "finish"
    t.integer  "position"
    t.integer  "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages", force: :cascade do |t|
    t.text     "name"
    t.text     "calpads_name"
    t.integer  "calpads_code"
    t.integer  "aeries_code"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "personas", force: :cascade do |t|
    t.integer  "student_id"
    t.string   "handler"
    t.string   "username"
    t.string   "password"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "state",        default: 0,  null: false
    t.string   "service_id"
    t.jsonb    "service_data", default: {}, null: false
    t.datetime "synced_at"
  end

  add_index "personas", ["handler", "username"], name: "index_personas_on_handler_and_username", unique: true, using: :btree
  add_index "personas", ["student_id"], name: "index_personas_on_student_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.text     "name"
    t.jsonb    "permissions", default: {}, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "roles", ["permissions"], name: "index_roles_on_permissions", using: :gin

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id"], name: "index_roles_users_on_role_id", using: :btree
  add_index "roles_users", ["user_id"], name: "index_roles_users_on_user_id", using: :btree

  create_table "sites", force: :cascade do |t|
    t.text     "name"
    t.text     "principal"
    t.text     "abbr"
    t.integer  "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_name"
    t.string   "sex"
    t.date     "birthdate"
    t.integer  "site_id"
    t.integer  "grade_id"
    t.integer  "homeroom_id"
    t.integer  "home_lang_id"
    t.integer  "ethnicity_id"
    t.integer  "race_id"
    t.integer  "family_id"
    t.integer  "enrollment_status", default: 0,  null: false
    t.integer  "flag",              default: 0,  null: false
    t.integer  "legacy_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.jsonb    "import_details",    default: {}, null: false
  end

  add_index "students", ["birthdate"], name: "index_students_on_birthdate", using: :btree
  add_index "students", ["first_name"], name: "index_students_on_first_name", using: :btree
  add_index "students", ["grade_id"], name: "index_students_on_grade_id", using: :btree
  add_index "students", ["home_lang_id"], name: "index_students_on_home_lang_id", using: :btree
  add_index "students", ["homeroom_id"], name: "index_students_on_homeroom_id", using: :btree
  add_index "students", ["last_name"], name: "index_students_on_last_name", using: :btree
  add_index "students", ["legacy_id"], name: "index_students_on_legacy_id", unique: true, using: :btree
  add_index "students", ["site_id"], name: "index_students_on_site_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.text     "first_name"
    t.text     "last_name"
    t.text     "image_url"
    t.text     "provider"
    t.text     "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "classroom_leaderships", "classrooms"
  add_foreign_key "classroom_leaderships", "employees"
  add_foreign_key "classroom_memberships", "classrooms"
  add_foreign_key "classroom_memberships", "students"
  add_foreign_key "classrooms", "sites"
  add_foreign_key "personas", "students"
  add_foreign_key "students", "grades"
  add_foreign_key "students", "sites"
end
