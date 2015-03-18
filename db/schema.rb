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

ActiveRecord::Schema.define(version: 20150311160003) do

  create_table "appeal_courses", force: true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "selected",   default: false
  end

  create_table "courses", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "department_id"
    t.string   "code"
    t.integer  "grade_id"
    t.integer  "main_course_id"
    t.boolean  "active",         default: true
    t.boolean  "is_elective",    default: false
  end

  add_index "courses", ["main_course_id"], name: "index_courses_on_main_course_id"

  create_table "current_courses", force: true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "selected",     default: false
    t.integer  "select_order"
  end

  create_table "current_electives", force: true do |t|
    t.integer  "elective_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", force: true do |t|
    t.string   "name"
    t.text     "description", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "elected_courses", force: true do |t|
    t.integer  "elective_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "electives", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "code"
    t.integer  "department_id"
    t.integer  "grade_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",        default: true
  end

  create_table "grades", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recommended_courses", force: true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "selected",   default: false
  end

  create_table "student_department_appeals", force: true do |t|
    t.integer  "user_id"
    t.integer  "department_id"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "selected",      default: false
  end

  create_table "taken_courses", force: true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_types", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_types", ["name"], name: "index_user_types_on_name", unique: true

  create_table "users", force: true do |t|
    t.string   "email",                     default: "",        null: false
    t.string   "encrypted_password",        default: "",        null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "full_name"
    t.string   "preferred_name"
    t.string   "export_id"
    t.integer  "current_grade_id"
    t.integer  "next_grade_id"
    t.integer  "user_type_id"
    t.boolean  "active",                    default: true
    t.boolean  "can_update",                default: true
    t.text     "student_notes"
    t.text     "registrar_notes"
    t.string   "auth_token"
    t.string   "current_enrollment_status", default: "Pending"
    t.string   "next_enrollment_status",    default: "Pending"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
