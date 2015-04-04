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

ActiveRecord::Schema.define(version: 20150404125216) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "evaluations", force: true do |t|
    t.integer  "reviewer_id"
    t.integer  "reviewed_user_id"
    t.integer  "score",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "evaluations", ["reviewed_user_id"], name: "index_evaluations_on_reviewed_user_id", using: :btree
  add_index "evaluations", ["reviewer_id"], name: "index_evaluations_on_reviewer_id", using: :btree

  create_table "messages", force: true do |t|
    t.text     "body",         null: false
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["recipient_id"], name: "index_messages_on_recipient_id", using: :btree
  add_index "messages", ["room_id"], name: "index_messages_on_room_id", using: :btree
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id", using: :btree

  create_table "rooms", force: true do |t|
    t.float    "latitude",                                      null: false
    t.float    "longitude",                                     null: false
    t.integer  "first_user_id"
    t.integer  "second_user_id"
    t.boolean  "displayed_for_first_user",      default: true,  null: false
    t.boolean  "displayed_for_second_user",     default: true,  null: false
    t.boolean  "first_user_profile_displayed",  default: false, null: false
    t.boolean  "second_user_profile_displayed", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "channel_name"
  end

  add_index "rooms", ["first_user_id"], name: "index_rooms_on_first_user_id", using: :btree
  add_index "rooms", ["second_user_id"], name: "index_rooms_on_second_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "gender",                 default: false, null: false
    t.integer  "min_age",                default: 18,    null: false
    t.integer  "max_age",                default: 80,    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "pictures"
    t.string   "username"
    t.string   "authentication_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
