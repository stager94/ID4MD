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

ActiveRecord::Schema.define(version: 20160701210643) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.date     "date"
    t.text     "text"
    t.integer  "medical_profile_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["medical_profile_id"], name: "index_appointments_on_medical_profile_id", using: :btree
  end

  create_table "diagnoses", force: :cascade do |t|
    t.date     "date"
    t.string   "laboratory"
    t.text     "address"
    t.integer  "medical_profile_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["medical_profile_id"], name: "index_diagnoses_on_medical_profile_id", using: :btree
  end

  create_table "doctors", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.string   "invited_by_type"
    t.integer  "invited_by_id"
    t.integer  "invitations_count",      default: 0
    t.integer  "availability",           default: 60
    t.string   "gender"
    t.text     "speciality"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.index ["email"], name: "index_doctors_on_email", unique: true, using: :btree
    t.index ["invitation_token"], name: "index_doctors_on_invitation_token", unique: true, using: :btree
    t.index ["invitations_count"], name: "index_doctors_on_invitations_count", using: :btree
    t.index ["invited_by_id"], name: "index_doctors_on_invited_by_id", using: :btree
    t.index ["reset_password_token"], name: "index_doctors_on_reset_password_token", unique: true, using: :btree
  end

  create_table "jobs", force: :cascade do |t|
    t.integer  "doctor_id"
    t.string   "name"
    t.text     "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_jobs_on_doctor_id", using: :btree
  end

  create_table "medical_profiles", force: :cascade do |t|
    t.integer  "patient_id"
    t.integer  "doctor_id"
    t.text     "diagnosis"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_medical_profiles_on_doctor_id", using: :btree
    t.index ["patient_id"], name: "index_medical_profiles_on_patient_id", using: :btree
  end

  create_table "patients", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.string   "invited_by_type"
    t.integer  "invited_by_id"
    t.integer  "invitations_count",      default: 0
    t.string   "first_name"
    t.string   "last_name"
    t.text     "diagnosis"
    t.string   "gender"
    t.string   "phone"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["email"], name: "index_patients_on_email", unique: true, using: :btree
    t.index ["invitation_token"], name: "index_patients_on_invitation_token", unique: true, using: :btree
    t.index ["invitations_count"], name: "index_patients_on_invitations_count", using: :btree
    t.index ["invited_by_id"], name: "index_patients_on_invited_by_id", using: :btree
    t.index ["reset_password_token"], name: "index_patients_on_reset_password_token", unique: true, using: :btree
  end

  create_table "visits", force: :cascade do |t|
    t.integer  "medical_profile_id"
    t.date     "date"
    t.text     "address"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["medical_profile_id"], name: "index_visits_on_medical_profile_id", using: :btree
  end

  add_foreign_key "appointments", "medical_profiles"
  add_foreign_key "diagnoses", "medical_profiles"
  add_foreign_key "jobs", "doctors"
  add_foreign_key "medical_profiles", "doctors"
  add_foreign_key "medical_profiles", "patients"
  add_foreign_key "visits", "medical_profiles"
end
