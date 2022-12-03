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

ActiveRecord::Schema.define(version: 20221121210951) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.string  "content"
    t.integer "event_id"
    t.integer "user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.string   "host"
    t.integer  "joined"
    t.text     "people"
    t.integer  "status"
    t.text     "description"
    t.datetime "event_time"
    t.integer  "attendee_limit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "rated_users"
    t.boolean  "promoted?",      default: false
    t.string   "category"
    t.string   "location"
  end

  create_table "events_users", id: false, force: :cascade do |t|
    t.integer "event_id", null: false
    t.integer "user_id",  null: false
  end

  create_table "reactions", force: :cascade do |t|
    t.integer "action"
    t.integer "comment_id"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "rating",                 default: 5,    null: false
    t.integer  "num_rating_got",         default: 1,    null: false
    t.integer  "coins",                  default: 100,  null: false
    t.boolean  "show_email",             default: true, null: false
    t.boolean  "show_my_events",         default: true, null: false
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
