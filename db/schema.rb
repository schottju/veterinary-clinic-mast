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

ActiveRecord::Schema.define(version: 20150902214311) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "street"
    t.string   "house_number"
    t.string   "flat_number"
    t.string   "city"
    t.string   "borough"
    t.string   "district"
    t.string   "province"
    t.string   "country"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "zip_code"
    t.integer  "user_id"
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

  create_table "animals", force: :cascade do |t|
    t.string   "id_number"
    t.string   "name"
    t.date     "birth_date"
    t.integer  "amount"
    t.float    "weight"
    t.integer  "gender"
    t.float    "age"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.integer  "species_id"
  end

  add_index "animals", ["species_id"], name: "index_animals_on_species_id", using: :btree
  add_index "animals", ["user_id"], name: "index_animals_on_user_id", using: :btree

  create_table "animals_medical_records", id: false, force: :cascade do |t|
    t.integer "medical_record_id", null: false
    t.integer "animal_id",         null: false
  end

  add_index "animals_medical_records", ["animal_id"], name: "index_animals_medical_records_on_animal_id", using: :btree
  add_index "animals_medical_records", ["medical_record_id"], name: "index_animals_medical_records_on_medical_record_id", using: :btree

  create_table "appointments", force: :cascade do |t|
    t.integer  "status",          default: 0
    t.integer  "kind",            default: 0
    t.integer  "user_id"
    t.integer  "veterinarian_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.date     "day"
    t.integer  "time",            default: 0
    t.text     "description"
  end

  add_index "appointments", ["user_id"], name: "index_appointments_on_user_id", using: :btree
  add_index "appointments", ["veterinarian_id"], name: "index_appointments_on_veterinarian_id", using: :btree

  create_table "diseases", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "status",     default: 0
  end

  create_table "diseases_medical_records", id: false, force: :cascade do |t|
    t.integer "disease_id",        null: false
    t.integer "medical_record_id", null: false
  end

  add_index "diseases_medical_records", ["disease_id"], name: "index_diseases_medical_records_on_disease_id", using: :btree
  add_index "diseases_medical_records", ["medical_record_id"], name: "index_diseases_medical_records_on_medical_record_id", using: :btree

  create_table "medical_records", force: :cascade do |t|
    t.text     "anamnesis"
    t.text     "description"
    t.text     "comment"
    t.integer  "user_id"
    t.integer  "veterinarian_id"
    t.float    "additional_cost"
    t.float    "total_cost"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "medical_records", ["user_id"], name: "index_medical_records_on_user_id", using: :btree
  add_index "medical_records", ["veterinarian_id"], name: "index_medical_records_on_veterinarian_id", using: :btree

  create_table "medical_records_medicines", id: false, force: :cascade do |t|
    t.integer "medical_record_id", null: false
    t.integer "medicine_id",       null: false
  end

  add_index "medical_records_medicines", ["medical_record_id"], name: "index_medical_records_medicines_on_medical_record_id", using: :btree
  add_index "medical_records_medicines", ["medicine_id"], name: "index_medical_records_medicines_on_medicine_id", using: :btree

  create_table "medical_records_pictures", id: false, force: :cascade do |t|
    t.integer "medical_record_id", null: false
    t.integer "picture_id",        null: false
  end

  add_index "medical_records_pictures", ["medical_record_id"], name: "index_medical_records_pictures_on_medical_record_id", using: :btree
  add_index "medical_records_pictures", ["picture_id"], name: "index_medical_records_pictures_on_picture_id", using: :btree

  create_table "medical_records_treatments", id: false, force: :cascade do |t|
    t.integer "medical_record_id", null: false
    t.integer "treatment_id",      null: false
  end

  add_index "medical_records_treatments", ["medical_record_id"], name: "index_medical_records_treatments_on_medical_record_id", using: :btree
  add_index "medical_records_treatments", ["treatment_id"], name: "index_medical_records_treatments_on_treatment_id", using: :btree

  create_table "medicines", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.float    "amount"
    t.integer  "grace_period"
    t.float    "price"
    t.string   "serial_number"
    t.text     "dosage"
    t.integer  "unit_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "medicines", ["unit_id"], name: "index_medicines_on_unit_id", using: :btree

  create_table "pictures", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "image"
    t.integer  "animal_id"
  end

  add_index "pictures", ["animal_id"], name: "index_pictures_on_animal_id", using: :btree
  add_index "pictures", ["user_id"], name: "index_pictures_on_user_id", using: :btree

  create_table "species", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "status",     default: 0
  end

  create_table "treatments", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.float    "cost"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "status",      default: 0
  end

  create_table "units", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "status",     default: 0
  end

  create_table "users", force: :cascade do |t|
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role",                   default: 0
    t.string   "pesel"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "vacations", force: :cascade do |t|
    t.date     "start"
    t.date     "end"
    t.integer  "veterinarian_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "vacations", ["veterinarian_id"], name: "index_vacations_on_veterinarian_id", using: :btree

  create_table "veterinarians", force: :cascade do |t|
    t.string   "title"
    t.string   "specialization"
    t.string   "pwz"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "veterinarians", ["user_id"], name: "index_veterinarians_on_user_id", using: :btree

  create_table "working_days", force: :cascade do |t|
    t.integer  "veterinarian_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "monday",          default: false
    t.boolean  "tuesday",         default: false
    t.boolean  "wednesday",       default: false
    t.boolean  "thursday",        default: false
    t.boolean  "friday",          default: false
    t.boolean  "saturday",        default: false
    t.boolean  "sunday",          default: false
  end

  add_index "working_days", ["veterinarian_id"], name: "index_working_days_on_veterinarian_id", using: :btree

  add_foreign_key "addresses", "users"
  add_foreign_key "animals", "species"
  add_foreign_key "animals", "users"
  add_foreign_key "appointments", "users"
  add_foreign_key "appointments", "veterinarians"
  add_foreign_key "medical_records", "users"
  add_foreign_key "medical_records", "veterinarians"
  add_foreign_key "medicines", "units"
  add_foreign_key "pictures", "animals"
  add_foreign_key "pictures", "users"
  add_foreign_key "vacations", "veterinarians"
  add_foreign_key "veterinarians", "users"
  add_foreign_key "working_days", "veterinarians"
end
