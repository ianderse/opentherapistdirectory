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

ActiveRecord::Schema.define(version: 20150204193059) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "facilities", force: true do |t|
    t.string   "name1"
    t.string   "name2"
    t.string   "website"
    t.string   "phone"
    t.string   "intake1"
    t.string   "intake2"
    t.string   "hotline1"
    t.string   "hotline2"
    t.string   "service_codes"
    t.text     "services_text1"
    t.text     "services_text2"
    t.text     "services_text3"
    t.text     "services_text4"
    t.text     "services_text5"
    t.text     "services_text6"
    t.text     "services_text7"
    t.string   "mail_street1"
    t.string   "mail_street2"
    t.string   "mail_city"
    t.string   "mail_state"
    t.string   "mail_zip"
    t.string   "mail_zip4"
    t.string   "location_street1"
    t.string   "location_street2"
    t.string   "location_city"
    t.string   "location_state"
    t.string   "location_zip"
    t.string   "location_zip4"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.integer "therapist_id"
    t.string  "city"
    t.string  "state"
    t.string  "zipcode"
    t.string  "street_1"
    t.string  "street_2"
  end

  create_table "therapists", force: true do |t|
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
  end

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
    t.text     "saved_facilities"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
