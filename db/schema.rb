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

ActiveRecord::Schema.define(version: 20141117212717) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "facilities", force: true do |t|
    t.string   "name_1"
    t.string   "name_2"
    t.string   "website"
    t.string   "phone"
    t.string   "intake_phone"
    t.text     "services_1"
    t.text     "services_2"
    t.text     "services_3"
    t.text     "services_4"
    t.text     "services_5"
    t.text     "services_6"
    t.text     "services_7"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facility_addresses", force: true do |t|
    t.string   "mail_street_1"
    t.string   "mail_street_2"
    t.string   "mail_city"
    t.string   "mail_state"
    t.string   "mail_zip"
    t.string   "mail_zip_2"
    t.string   "location_street_1"
    t.string   "location_street_2"
    t.string   "location_city"
    t.string   "location_state"
    t.string   "location_zip"
    t.string   "location_zip_2"
    t.integer  "facility_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "facility_addresses", ["facility_id"], name: "index_facility_addresses_on_facility_id", using: :btree

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
