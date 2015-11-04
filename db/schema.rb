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

ActiveRecord::Schema.define(version: 20151104110830) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "authentications", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "provider",   null: false
    t.text     "uid",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid     "user_id",    null: false
  end

  add_index "authentications", ["provider", "uid"], name: "index_authentications_on_provider_and_uid", using: :btree

  create_table "comments", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "body",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid     "user_id",    null: false
    t.uuid     "rating_id",  null: false
    t.uuid     "parent_id"
  end

  add_index "comments", ["rating_id"], name: "index_comments_on_rating_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "likes", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid     "user_id",    null: false
    t.uuid     "rating_id",  null: false
  end

  add_index "likes", ["rating_id", "user_id"], name: "index_likes_on_rating_id_and_user_id", unique: true, using: :btree

  create_table "pages", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "body",       null: false
    t.text     "slug",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "title",      null: false
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true, using: :btree

  create_table "rating_items", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "position",                  null: false
    t.integer  "mark",         default: 0,  null: false
    t.text     "title"
    t.text     "description"
    t.text     "image"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.uuid     "rating_id",                 null: false
    t.json     "video",        default: {}, null: false
    t.integer  "image_height"
  end

  add_index "rating_items", ["rating_id"], name: "index_rating_items_on_rating_id", using: :btree

  create_table "ratings", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "title"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.uuid     "section_id"
    t.text     "description"
    t.uuid     "user_id"
    t.integer  "status",             default: 0,  null: false
    t.integer  "comments_count",     default: 0,  null: false
    t.integer  "likes_count",        default: 0,  null: false
    t.text     "slug"
    t.text     "image"
    t.datetime "published_at"
    t.datetime "deleted_at"
    t.text     "source"
    t.text     "words",              default: [],              array: true
    t.uuid     "recommendations",    default: [],              array: true
    t.integer  "main_page_position"
  end

  add_index "ratings", ["deleted_at"], name: "index_ratings_on_deleted_at", using: :btree
  add_index "ratings", ["main_page_position"], name: "index_ratings_on_main_page_position", unique: true, using: :btree
  add_index "ratings", ["section_id"], name: "index_ratings_on_section_id", using: :btree
  add_index "ratings", ["slug"], name: "index_ratings_on_slug", unique: true, using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "ratings_tags", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid "rating_id", null: false
    t.uuid "tag_id",    null: false
  end

  add_index "ratings_tags", ["rating_id"], name: "index_ratings_tags_on_rating_id", using: :btree
  add_index "ratings_tags", ["tag_id"], name: "index_ratings_tags_on_tag_id", using: :btree

  create_table "sections", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "name",                         null: false
    t.text     "color",                        null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.text     "slug",                         null: false
    t.integer  "position",         default: 0, null: false
    t.text     "meta_title",                   null: false
    t.text     "meta_description",             null: false
    t.text     "meta_keywords",                null: false
    t.text     "inverted_color"
  end

  add_index "sections", ["slug"], name: "index_sections_on_slug", unique: true, using: :btree

  create_table "tags", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "name",                      null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "ratings_count", default: 0, null: false
    t.text     "slug",                      null: false
  end

  add_index "tags", ["slug"], name: "index_tags_on_slug", unique: true, using: :btree

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "email"
    t.text     "crypted_password"
    t.text     "salt"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.text     "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.text     "name"
    t.text     "avatar"
    t.text     "facebook_link"
    t.text     "instagram_link"
    t.text     "slug",                                        null: false
    t.integer  "role",                            default: 0, null: false
    t.text     "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.text     "background"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

  create_table "votes", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "kind",           null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.uuid     "user_id",        null: false
    t.uuid     "rating_item_id", null: false
  end

  add_index "votes", ["rating_item_id"], name: "index_votes_on_rating_item_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

  add_foreign_key "authentications", "users"
  add_foreign_key "comments", "comments", column: "parent_id"
  add_foreign_key "comments", "ratings"
  add_foreign_key "comments", "users"
  add_foreign_key "likes", "ratings"
  add_foreign_key "likes", "users"
  add_foreign_key "rating_items", "ratings"
  add_foreign_key "ratings", "sections"
  add_foreign_key "ratings", "users"
  add_foreign_key "ratings_tags", "ratings"
  add_foreign_key "ratings_tags", "tags"
  add_foreign_key "votes", "rating_items"
  add_foreign_key "votes", "users"
end
