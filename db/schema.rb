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

ActiveRecord::Schema.define(version: 20150422001718) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alerts", force: :cascade do |t|
    t.string   "description"
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "start"
    t.datetime "ending"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.text     "recurrence"
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "events_facilities", id: false, force: :cascade do |t|
    t.integer "event_id"
    t.integer "facility_id"
  end

  add_index "events_facilities", ["event_id", "facility_id"], name: "index_events_facilities_on_event_id_and_facility_id", using: :btree
  add_index "events_facilities", ["facility_id"], name: "index_events_facilities_on_facility_id", using: :btree

  create_table "events_resources", id: false, force: :cascade do |t|
    t.integer "event_id"
    t.integer "resource_id"
  end

  add_index "events_resources", ["event_id", "resource_id"], name: "index_events_resources_on_event_id_and_resource_id", using: :btree
  add_index "events_resources", ["resource_id"], name: "index_events_resources_on_resource_id", using: :btree

  create_table "facilities", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "capacity"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "storage_location"
    t.time     "max_reserve_time"
  end

  create_table "resources", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "numberOf"
    t.string   "storage_location"
    t.time     "max_reserve_time"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.integer  "phone"
    t.string   "home_group"
    t.integer  "user_level",      default: 0
    t.boolean  "activated",       default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "events", "users"
end
