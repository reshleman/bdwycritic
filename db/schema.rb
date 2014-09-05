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

ActiveRecord::Schema.define(version: 20140905143607) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_preferences", force: true do |t|
    t.integer  "user_id",      null: false
    t.integer  "event_id",     null: false
    t.boolean  "wants_to_see"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_preferences", ["event_id"], name: "index_event_preferences_on_event_id", using: :btree
  add_index "event_preferences", ["user_id"], name: "index_event_preferences_on_user_id", using: :btree

  create_table "events", force: true do |t|
    t.string   "name",                          null: false
    t.string   "venue"
    t.text     "description"
    t.date     "closing_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nyt_event_id"
    t.datetime "nyt_updated_at"
    t.integer  "num_user_reviews",  default: 0
    t.integer  "num_media_reviews", default: 0
  end

  create_table "media_reviews", force: true do |t|
    t.string   "url",        null: false
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "headline",   null: false
    t.string   "author"
    t.string   "source",     null: false
    t.float    "sentiment"
  end

  add_index "media_reviews", ["event_id"], name: "index_media_reviews_on_event_id", using: :btree

  create_table "user_reviews", force: true do |t|
    t.text     "body",       null: false
    t.integer  "rating",     null: false
    t.integer  "user_id",    null: false
    t.integer  "event_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_reviews", ["event_id"], name: "index_user_reviews_on_event_id", using: :btree
  add_index "user_reviews", ["user_id"], name: "index_user_reviews_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                           null: false
    t.string   "password_digest",                 null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "admin",           default: false
    t.string   "first_name",                      null: false
    t.string   "last_name",                       null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
