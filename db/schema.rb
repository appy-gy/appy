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

ActiveRecord::Schema.define(version: 20150420213236) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.text     "provider",   null: false
    t.text     "uid",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "authentications", ["provider", "uid"], name: "index_authentications_on_provider_and_uid", using: :btree

  create_table "rating_items", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "position",                null: false
    t.integer  "mark",        default: 0, null: false
    t.text     "title"
    t.text     "description"
    t.text     "image"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.uuid     "rating_id",               null: false
  end

  create_table "ratings", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "title",       null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.uuid     "section_id",  null: false
    t.text     "description"
    t.uuid     "user_id"
  end

  add_index "ratings", ["section_id"], name: "index_ratings_on_section_id", using: :btree

  create_table "ratings_tags", id: false, force: :cascade do |t|
    t.uuid "rating_id", null: false
    t.uuid "tag_id",    null: false
  end

  add_index "ratings_tags", ["rating_id"], name: "index_ratings_tags_on_rating_id", using: :btree
  add_index "ratings_tags", ["tag_id"], name: "index_ratings_tags_on_tag_id", using: :btree

  create_table "sections", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "name",       null: false
    t.text     "color",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tags", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "email"
    t.text     "crypted_password"
    t.text     "salt"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.text     "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.text     "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.text     "name"
    t.text     "avatar"
    t.text     "facebook_link"
    t.text     "instagram_link"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

  add_foreign_key "ratings", "sections"
  add_foreign_key "ratings_tags", "ratings"
  add_foreign_key "ratings_tags", "tags"
end
