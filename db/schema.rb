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

ActiveRecord::Schema.define(version: 20160531050501) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "competitions", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.string   "prize"
    t.datetime "end_date"
    t.integer  "number_of_entries"
    t.integer  "number_of_views"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "featured",          default: false
    t.integer  "category_id"
    t.integer  "user_id"
    t.string   "image"
  end

  add_index "competitions", ["category_id"], name: "index_competitions_on_category_id", using: :btree
  add_index "competitions", ["user_id"], name: "index_competitions_on_user_id", using: :btree

  create_table "contests", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.string   "prize"
    t.datetime "end_date"
    t.boolean  "featured",    default: false
    t.string   "image"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "category_id"
    t.integer  "user_id"
  end

  add_index "contests", ["category_id"], name: "index_contests_on_category_id", using: :btree
  add_index "contests", ["user_id"], name: "index_contests_on_user_id", using: :btree

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

  create_table "entries", force: :cascade do |t|
    t.integer  "contest_id"
    t.integer  "user_id"
    t.string   "entered",    default: "f"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "entries", ["contest_id"], name: "index_entries_on_contest_id", using: :btree
  add_index "entries", ["user_id"], name: "index_entries_on_user_id", using: :btree

  create_table "user_images", force: :cascade do |t|
    t.string   "image"
    t.integer  "competition_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "user_images", ["competition_id"], name: "index_user_images_on_competition_id", using: :btree

  create_table "user_photos", force: :cascade do |t|
    t.string   "photo"
    t.integer  "competition_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "user_photos", ["competition_id"], name: "index_user_photos_on_competition_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin",                             default: false
    t.boolean  "activated",                         default: false
    t.string   "account_verification_token"
    t.datetime "account_verification_requested_at"
    t.string   "password_reset_token"
    t.datetime "password_reset_requested_at"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "user_type"
  end

  add_foreign_key "competitions", "categories"
  add_foreign_key "competitions", "users"
  add_foreign_key "contests", "categories"
  add_foreign_key "contests", "users"
  add_foreign_key "entries", "contests"
  add_foreign_key "entries", "users"
  add_foreign_key "user_images", "competitions"
  add_foreign_key "user_photos", "competitions"
end
