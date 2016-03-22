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

ActiveRecord::Schema.define(version: 20160314212248) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"
  enable_extension "pg_trgm"

  create_table "addresses", force: :cascade do |t|
    t.text     "label",            default: "mailing", null: false
    t.text     "street"
    t.text     "city"
    t.text     "state",            default: "CA",      null: false
    t.text     "country",          default: "USA",     null: false
    t.integer  "zip",              default: 91355,     null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.text     "name"
    t.text     "street2"
  end

  add_index "addresses", ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id", using: :btree
  add_index "addresses", ["city"], name: "index_addresses_on_city", using: :btree
  add_index "addresses", ["label"], name: "index_addresses_on_label", using: :btree
  add_index "addresses", ["street"], name: "index_addresses_on_street", using: :btree

  create_table "assessments", force: :cascade do |t|
    t.integer  "student_id"
    t.string   "name"
    t.jsonb    "data",       default: {}, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.date     "taken_on"
  end

  add_index "assessments", ["data"], name: "index_assessments_on_data", using: :gin
  add_index "assessments", ["student_id"], name: "index_assessments_on_student_id", using: :btree
  add_index "assessments", ["taken_on"], name: "index_assessments_on_taken_on", using: :btree

  create_table "attendances", force: :cascade do |t|
    t.integer  "student_id"
    t.date     "date"
    t.integer  "day",            default: 0,  null: false
    t.integer  "kind",           default: 0,  null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.jsonb    "import_details", default: {}, null: false
  end

  add_index "attendances", ["student_id"], name: "index_attendances_on_student_id", using: :btree

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
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "state",        default: 0, null: false
    t.integer  "source",       default: 0, null: false
  end

  add_index "classroom_memberships", ["classroom_id"], name: "index_classroom_memberships_on_classroom_id", using: :btree
  add_index "classroom_memberships", ["student_id"], name: "index_classroom_memberships_on_student_id", using: :btree

  create_table "classrooms", force: :cascade do |t|
    t.string   "name"
    t.integer  "site_id"
    t.jsonb    "import_details",     default: {}, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "primary_teacher_id"
  end

  add_index "classrooms", ["site_id"], name: "index_classrooms_on_site_id", using: :btree

  create_table "comments_report_cards", id: false, force: :cascade do |t|
    t.integer "report_card_comment_id"
    t.integer "report_card_id"
  end

  add_index "comments_report_cards", ["report_card_comment_id", "report_card_id"], name: "index_comments_report_cards", unique: true, using: :btree

  create_table "contacts", force: :cascade do |t|
    t.integer  "contactable_id"
    t.string   "contactable_type"
    t.string   "label"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.text     "note"
    t.jsonb    "import_details"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "relationship"
    t.integer  "position"
  end

  add_index "contacts", ["contactable_type", "contactable_id"], name: "index_contacts_on_contactable_type_and_contactable_id", using: :btree

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
    t.integer  "years_edu",       default: 0,  null: false
    t.integer  "years_district",  default: 0,  null: false
    t.string   "title"
    t.integer  "state",           default: 0,  null: false
    t.integer  "legacy_id"
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.jsonb    "import_details",  default: {}, null: false
    t.integer  "primary_site_id"
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

  create_table "enrollments", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "site_id"
    t.integer  "classroom_id"
    t.integer  "grade_id"
    t.integer  "year",           default: 2015
    t.integer  "state",          default: 0,    null: false
    t.date     "starts_on"
    t.date     "ends_on"
    t.jsonb    "import_details", default: {},   null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "enrollments", ["classroom_id"], name: "index_enrollments_on_classroom_id", using: :btree
  add_index "enrollments", ["grade_id"], name: "index_enrollments_on_grade_id", using: :btree
  add_index "enrollments", ["site_id"], name: "index_enrollments_on_site_id", using: :btree
  add_index "enrollments", ["student_id"], name: "index_enrollments_on_student_id", using: :btree

  create_table "eval_notes", force: :cascade do |t|
    t.integer  "evaluation_id"
    t.text     "label"
    t.text     "body"
    t.jsonb    "data",          default: {}
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "eval_notes", ["data"], name: "index_eval_notes_on_data", using: :btree
  add_index "eval_notes", ["evaluation_id"], name: "index_eval_notes_on_evaluation_id", using: :btree
  add_index "eval_notes", ["label"], name: "index_eval_notes_on_label", using: :btree

  create_table "evaluations", force: :cascade do |t|
    t.integer  "employee_id"
    t.datetime "taken_at"
    t.jsonb    "data",         default: {}
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "evaluator_id"
  end

  add_index "evaluations", ["data"], name: "index_evaluations_on_data", using: :btree
  add_index "evaluations", ["employee_id"], name: "index_evaluations_on_employee_id", using: :btree
  add_index "evaluations", ["taken_at"], name: "index_evaluations_on_taken_at", using: :btree

  create_table "gapps_org_unit_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "gapps_org_unit_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "org_unit_anc_desc_idx", unique: true, using: :btree
  add_index "gapps_org_unit_hierarchies", ["descendant_id"], name: "org_unit_desc_idx", using: :btree

  create_table "gapps_org_units", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "parent_id"
    t.string   "gapps_id"
    t.string   "gapps_path"
    t.string   "gapps_parent_id"
    t.string   "gapps_parent_path"
    t.datetime "synced_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "state",             default: 0, null: false
  end

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
    t.string   "locale"
  end

  create_table "personas", force: :cascade do |t|
    t.integer  "student_id"
    t.string   "handler"
    t.string   "username"
    t.string   "password"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "state",           default: 0,         null: false
    t.string   "service_id"
    t.jsonb    "service_data",    default: {},        null: false
    t.datetime "synced_at"
    t.integer  "personable_id"
    t.string   "personable_type", default: "Student"
  end

  add_index "personas", ["handler", "username"], name: "index_personas_on_handler_and_username", unique: true, using: :btree
  add_index "personas", ["personable_id", "personable_type"], name: "index_personas_on_personable_id_and_personable_type", using: :btree
  add_index "personas", ["student_id"], name: "index_personas_on_student_id", using: :btree

  create_table "phones", force: :cascade do |t|
    t.string   "label"
    t.string   "original"
    t.integer  "callable_id"
    t.string   "callable_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "normal"
  end

  add_index "phones", ["callable_type", "callable_id"], name: "index_phones_on_callable_type_and_callable_id", using: :btree
  add_index "phones", ["label"], name: "index_phones_on_label", using: :btree
  add_index "phones", ["normal"], name: "index_phones_on_normal", using: :btree
  add_index "phones", ["original"], name: "index_phones_on_original", using: :btree

  create_table "report_card_comment_groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "report_card_form_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "report_card_comment_groups", ["report_card_form_id"], name: "index_report_card_comment_groups_on_report_card_form_id", using: :btree

  create_table "report_card_comments", force: :cascade do |t|
    t.text     "english"
    t.text     "spanish"
    t.integer  "report_card_comment_group_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "report_card_comments", ["report_card_comment_group_id"], name: "index_report_card_comments_on_report_card_comment_group_id", using: :btree

  create_table "report_card_form_options", force: :cascade do |t|
    t.string   "field_name"
    t.integer  "field_type",          default: 0,  null: false
    t.jsonb    "data",                default: {}, null: false
    t.integer  "report_card_form_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "report_card_form_options", ["data"], name: "index_report_card_form_options_on_data", using: :gin
  add_index "report_card_form_options", ["report_card_form_id"], name: "index_report_card_form_options_on_report_card_form_id", using: :btree

  create_table "report_card_forms", force: :cascade do |t|
    t.string   "name"
    t.string   "renderer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "report_card_grading_periods", force: :cascade do |t|
    t.date     "starts_on"
    t.date     "ends_on"
    t.integer  "position",   default: 0,    null: false
    t.integer  "year",       default: 2015, null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "report_card_subjects", force: :cascade do |t|
    t.string   "name"
    t.string   "spanish_name"
    t.string   "slug"
    t.integer  "report_card_form_id"
    t.integer  "position"
    t.boolean  "major"
    t.boolean  "show_score"
    t.boolean  "show_effort"
    t.boolean  "show_level"
    t.boolean  "side_section"
    t.boolean  "positional_score"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "report_card_subjects", ["report_card_form_id"], name: "index_report_card_subjects_on_report_card_form_id", using: :btree

  create_table "report_cards", force: :cascade do |t|
    t.integer  "student_id"
    t.integer  "report_card_form_id"
    t.jsonb    "data",                default: {},   null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.jsonb    "import_details",      default: {},   null: false
    t.integer  "year",                default: 2015, null: false
    t.integer  "employee_id"
    t.text     "pdf_path"
    t.integer  "legacy_id"
  end

  add_index "report_cards", ["employee_id"], name: "index_report_cards_on_employee_id", using: :btree
  add_index "report_cards", ["legacy_id"], name: "index_report_cards_on_legacy_id", using: :btree
  add_index "report_cards", ["report_card_form_id"], name: "index_report_cards_on_report_card_form_id", using: :btree
  add_index "report_cards", ["student_id"], name: "index_report_cards_on_student_id", using: :btree

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

  create_table "settings", force: :cascade do |t|
    t.string   "name",                    null: false
    t.jsonb    "data",       default: {}, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "settings", ["data"], name: "index_settings_on_data", using: :gin
  add_index "settings", ["name"], name: "index_settings_on_name", unique: true, using: :btree

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
    t.integer  "enrollment_status",           default: 0,  null: false
    t.integer  "flag",                        default: 0,  null: false
    t.integer  "legacy_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.jsonb    "import_details",              default: {}, null: false
    t.integer  "state",                       default: 0,  null: false
    t.integer  "ssid",              limit: 8
  end

  add_index "students", ["birthdate"], name: "index_students_on_birthdate", using: :btree
  add_index "students", ["first_name"], name: "index_students_on_first_name", using: :btree
  add_index "students", ["grade_id"], name: "index_students_on_grade_id", using: :btree
  add_index "students", ["home_lang_id"], name: "index_students_on_home_lang_id", using: :btree
  add_index "students", ["homeroom_id"], name: "index_students_on_homeroom_id", using: :btree
  add_index "students", ["last_name"], name: "index_students_on_last_name", using: :btree
  add_index "students", ["legacy_id"], name: "index_students_on_legacy_id", unique: true, using: :btree
  add_index "students", ["site_id"], name: "index_students_on_site_id", using: :btree
  add_index "students", ["ssid"], name: "index_students_on_ssid", using: :btree
  add_index "students", ["state"], name: "index_students_on_state", using: :btree

  create_table "sync_events", force: :cascade do |t|
    t.string   "label"
    t.integer  "state",         default: 0, null: false
    t.integer  "action",        default: 0, null: false
    t.integer  "syncable_id"
    t.string   "syncable_type"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "sync_events", ["action"], name: "index_sync_events_on_action", using: :btree
  add_index "sync_events", ["label"], name: "index_sync_events_on_label", using: :btree
  add_index "sync_events", ["state"], name: "index_sync_events_on_state", using: :btree
  add_index "sync_events", ["syncable_type", "syncable_id"], name: "index_sync_events_on_syncable_type_and_syncable_id", using: :btree

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

  add_foreign_key "assessments", "students"
  add_foreign_key "attendances", "students"
  add_foreign_key "classroom_leaderships", "classrooms"
  add_foreign_key "classroom_leaderships", "employees"
  add_foreign_key "classroom_memberships", "classrooms"
  add_foreign_key "classroom_memberships", "students"
  add_foreign_key "classrooms", "sites"
  add_foreign_key "enrollments", "classrooms"
  add_foreign_key "enrollments", "grades"
  add_foreign_key "enrollments", "sites"
  add_foreign_key "enrollments", "students"
  add_foreign_key "eval_notes", "evaluations"
  add_foreign_key "evaluations", "employees"
  add_foreign_key "personas", "students"
  add_foreign_key "report_card_comment_groups", "report_card_forms"
  add_foreign_key "report_card_comments", "report_card_comment_groups"
  add_foreign_key "report_card_form_options", "report_card_forms"
  add_foreign_key "report_card_subjects", "report_card_forms"
  add_foreign_key "report_cards", "employees"
  add_foreign_key "report_cards", "report_card_forms"
  add_foreign_key "report_cards", "students"
  add_foreign_key "students", "grades"
  add_foreign_key "students", "sites"
end
