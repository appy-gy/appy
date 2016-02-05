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

ActiveRecord::Schema.define(version: 20160202201003) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"
  enable_extension "hstore"

  create_table "accreditation_requests", force: :cascade do |t|
    t.boolean  "sent",           default: false, null: false
    t.boolean  "processed",      default: false, null: false
    t.boolean  "accepted"
    t.text     "decline_reason"
    t.integer  "role_id",                        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accreditation_requests", ["role_id"], name: "index_accreditation_requests_on_role_id", using: :btree

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body"
    t.string   "resource_id",   limit: 255, null: false
    t.string   "resource_type", limit: 255, null: false
    t.integer  "author_id"
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "amo_backups", force: :cascade do |t|
    t.string   "contacts_file"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "leads_file"
    t.string   "lead_notes_file"
    t.string   "contact_notes_file"
  end

  create_table "amo_companies", force: :cascade do |t|
    t.integer  "amo_id",      null: false
    t.text     "name",        null: false
    t.datetime "date_create", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
    t.text     "url"
  end

  add_index "amo_companies", ["amo_id"], name: "index_amo_companies_on_amo_id", using: :btree
  add_index "amo_companies", ["project_id"], name: "index_amo_companies_on_project_id", using: :btree

  create_table "amo_contacts", force: :cascade do |t|
    t.integer  "amo_id",        null: false
    t.text     "name",          null: false
    t.text     "email"
    t.datetime "date_create",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "investor_id"
    t.text     "phone"
    t.text     "tags",                       array: true
    t.text     "investor_type"
  end

  add_index "amo_contacts", ["amo_id"], name: "index_amo_contacts_on_amo_id", using: :btree
  add_index "amo_contacts", ["investor_id"], name: "index_amo_contacts_on_investor_id", using: :btree

  create_table "amo_contacts_leads", force: :cascade do |t|
    t.integer  "contact_id", null: false
    t.integer  "lead_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "amo_contacts_leads", ["contact_id"], name: "index_amo_contacts_leads_on_contact_id", using: :btree
  add_index "amo_contacts_leads", ["lead_id"], name: "index_amo_contacts_leads_on_lead_id", using: :btree

  create_table "amo_lead_status_changes", force: :cascade do |t|
    t.integer  "lead_id",    null: false
    t.integer  "status_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "amo_lead_status_changes", ["status_id"], name: "index_amo_lead_status_changes_on_status_id", using: :btree

  create_table "amo_leads", force: :cascade do |t|
    t.integer  "amo_id",                     null: false
    t.text     "name",                       null: false
    t.text     "tags",          default: [], null: false, array: true
    t.datetime "date_create",                null: false
    t.integer  "status_id",                  null: false
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_modified"
  end

  add_index "amo_leads", ["amo_id"], name: "index_amo_leads_on_amo_id", using: :btree
  add_index "amo_leads", ["company_id"], name: "index_amo_leads_on_company_id", using: :btree
  add_index "amo_leads", ["status_id"], name: "index_amo_leads_on_status_id", using: :btree

  create_table "amo_statuses", force: :cascade do |t|
    t.integer  "amo_id",     null: false
    t.text     "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "amo_statuses", ["amo_id"], name: "index_amo_statuses_on_amo_id", using: :btree

  create_table "arrangement_organizers", force: :cascade do |t|
    t.text     "title",          null: false
    t.text     "url"
    t.text     "image"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "arrangement_id", null: false
  end

  add_index "arrangement_organizers", ["arrangement_id"], name: "index_arrangement_organizers_on_arrangement_id", using: :btree

  create_table "arrangements", force: :cascade do |t|
    t.text     "title",                         null: false
    t.text     "body"
    t.text     "image"
    t.datetime "start_at"
    t.integer  "places_count"
    t.text     "location_name"
    t.float    "location_lat"
    t.float    "location_lng"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.text     "location_address"
    t.text     "url"
    t.text     "phone"
    t.integer  "status",           default: 0,  null: false
    t.integer  "kind",                          null: false
    t.text     "slug"
    t.integer  "price"
    t.datetime "dates",            default: [], null: false, array: true
  end

  add_index "arrangements", ["slug"], name: "index_arrangements_on_slug", using: :btree
  add_index "arrangements", ["status"], name: "index_arrangements_on_status", using: :btree

  create_table "arrangements_projects", force: :cascade do |t|
    t.integer "project_id",     null: false
    t.integer "arrangement_id", null: false
  end

  add_index "arrangements_projects", ["arrangement_id"], name: "index_arrangements_projects_on_arrangement_id", using: :btree
  add_index "arrangements_projects", ["project_id"], name: "index_arrangements_projects_on_project_id", using: :btree

  create_table "authentications", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "provider",   null: false
    t.text     "uid",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid     "user_id",    null: false
  end

  add_index "authentications", ["provider", "uid"], name: "index_authentications_on_provider_and_uid", using: :btree

  create_table "auto_email_footers", force: :cascade do |t|
    t.text     "content"
    t.string   "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "badge_lists", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "kind",       default: 0, null: false
  end

  create_table "badge_logos", force: :cascade do |t|
    t.string   "image",      limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "badges", force: :cascade do |t|
    t.string   "surname",                   default: ""
    t.string   "name",                      default: ""
    t.string   "color",         limit: 255,              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "badge_list_id"
    t.integer  "badge_logo_id"
    t.string   "role",                      default: ""
  end

  add_index "badges", ["badge_logo_id"], name: "index_badges_on_badge_logo_id", using: :btree

  create_table "banner_clicks", force: :cascade do |t|
    t.integer  "banner_id",  null: false
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "banner_clicks", ["banner_id"], name: "index_banner_clicks_on_banner_id", using: :btree
  add_index "banner_clicks", ["user_id"], name: "index_banner_clicks_on_user_id", using: :btree

  create_table "banners", force: :cascade do |t|
    t.text     "name",                     null: false
    t.text     "url"
    t.text     "attachment",               null: false
    t.datetime "start_at",                 null: false
    t.datetime "finish_at"
    t.integer  "shows_limit"
    t.integer  "priority",     default: 1, null: false
    t.integer  "clicks_count", default: 0, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "position",                 null: false
  end

  create_table "binaries", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_id"
    t.string   "item_type",  limit: 255
    t.string   "file",       limit: 255
    t.json     "info",                   default: {}, null: false
  end

  add_index "binaries", ["item_id", "item_type"], name: "index_binaries_on_item_id_and_item_type", using: :btree

  create_table "browser_notification_subscriptions", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "browser",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid     "user_id"
    t.text     "endpoint",   null: false
  end

  add_index "browser_notification_subscriptions", ["endpoint", "browser"], name: "index_bns_on_endpoint_and_browser", unique: true, using: :btree

  create_table "browser_notifications", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.json     "payload",          default: {}, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.uuid     "subscription_ids", default: [], null: false, array: true
  end

  add_index "browser_notifications", ["subscription_ids"], name: "index_browser_notifications_on_subscription_ids", using: :gin

  create_table "bulk_emails", force: :cascade do |t|
    t.string   "title",            limit: 255,                 null: false
    t.text     "body",                                         null: false
    t.text     "css"
    t.integer  "sended_count"
    t.datetime "run_at"
    t.boolean  "runned",                       default: false, null: false
    t.string   "recipient_types",  limit: 255, default: [],    null: false, array: true
    t.string   "recipient_emails", limit: 255, default: [],    null: false, array: true
    t.integer  "user_id",                                      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "sms",                          default: false, null: false
    t.string   "item_type"
    t.integer  "item_id"
    t.text     "sms_text"
  end

  add_index "bulk_emails", ["user_id"], name: "index_bulk_emails_on_user_id", using: :btree

  create_table "call_event_groups", force: :cascade do |t|
    t.text     "phone"
    t.integer  "status",      default: 0, null: false
    t.datetime "callback_at"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "call_events", force: :cascade do |t|
    t.text     "type",                             null: false
    t.json     "info",                default: {}, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "item_id",                          null: false
    t.string   "item_type",                        null: false
    t.integer  "call_event_group_id"
  end

  create_table "callmart_calls", force: :cascade do |t|
    t.json     "info",                default: {}, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "call_event_group_id"
  end

  add_index "callmart_calls", ["call_event_group_id"], name: "index_callmart_calls_on_call_event_group_id", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["region_id"], name: "index_cities_on_region_id", using: :btree

  create_table "city_codes", force: :cascade do |t|
    t.text     "name",                    null: false
    t.integer  "codes",      default: [], null: false, array: true
    t.decimal  "lat",                     null: false
    t.decimal  "lng",                     null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "client_errors", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.json     "info",       default: {}, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "coinvestors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "kind",       limit: 255
    t.integer  "value"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coinvestors", ["name"], name: "index_coinvestors_on_name", using: :btree

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

  create_table "countries", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: :cascade do |t|
    t.string   "title"
    t.integer  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crowd_document_templates", force: :cascade do |t|
    t.string   "file"
    t.integer  "project_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "crowd_document_templates", ["project_id"], name: "index_crowd_document_templates_on_project_id", using: :btree

  create_table "crowd_investment_campaigns", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "status",          default: 0
    t.datetime "finish_at"
    t.integer  "st_comission"
    t.datetime "start_at"
    t.integer  "amount"
    t.integer  "lot_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "number"
    t.string   "lot_description"
  end

  create_table "crowd_investment_documents", force: :cascade do |t|
    t.boolean  "signed",                     default: false, null: false
    t.json     "sign_me_info",               default: {},    null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "user_id",                                    null: false
    t.integer  "project_id",                                 null: false
    t.integer  "crowd_investment_id"
    t.integer  "payment_id"
    t.string   "file"
    t.integer  "crowd_document_template_id"
  end

  add_index "crowd_investment_documents", ["crowd_document_template_id"], name: "index_crowd_investment_documents_on_crowd_document_template_id", using: :btree
  add_index "crowd_investment_documents", ["project_id"], name: "index_crowd_investment_documents_on_project_id", using: :btree
  add_index "crowd_investment_documents", ["user_id"], name: "index_crowd_investment_documents_on_user_id", using: :btree

  create_table "crowdlending_deal_prolongations", force: :cascade do |t|
    t.boolean  "capitalization",          null: false
    t.integer  "maturity",                null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "crowdlending_payment_id", null: false
    t.text     "agreement"
    t.date     "agreement_created_at"
  end

  create_table "crowdlending_deals", force: :cascade do |t|
    t.integer  "percent",                      null: false
    t.integer  "amount",                       null: false
    t.integer  "status",                       null: false
    t.integer  "maturity",                     null: false
    t.datetime "locked_until"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.text     "order_number"
    t.boolean  "cloned",       default: false, null: false
  end

  create_table "crowdlending_payments", force: :cascade do |t|
    t.integer  "status",                                    null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "user_id",                                   null: false
    t.integer  "crowdlending_deal_id",                      null: false
    t.boolean  "confirmed",                 default: false, null: false
    t.text     "agreement"
    t.datetime "paid_at"
    t.integer  "payer_type",                default: 0,     null: false
    t.datetime "paid_out_at"
    t.date     "agreement_created_at"
    t.text     "recipient"
    t.text     "destiny"
    t.boolean  "custom_recipient_approved", default: false, null: false
    t.json     "payment_details",           default: {},    null: false
  end

  add_index "crowdlending_payments", ["crowdlending_deal_id"], name: "index_crowdlending_payments_on_crowdlending_deal_id", using: :btree
  add_index "crowdlending_payments", ["user_id"], name: "index_crowdlending_payments_on_user_id", using: :btree

  create_table "devices", force: :cascade do |t|
    t.integer  "platform"
    t.text     "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "devices", ["platform", "key"], name: "index_devices_on_platform_and_key", using: :btree

  create_table "email_lists", force: :cascade do |t|
    t.string "name",   limit: 255,              null: false
    t.string "emails", limit: 255, default: [], null: false, array: true
  end

  create_table "email_logs", force: :cascade do |t|
    t.text     "subject",                null: false
    t.text     "body",                   null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",      limit: 255
  end

  create_table "event_images", force: :cascade do |t|
    t.string   "image",      limit: 255
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_images", ["event_id"], name: "index_event_images_on_event_id", using: :btree

  create_table "event_notifiers", force: :cascade do |t|
    t.string   "name",        limit: 255,              null: false
    t.text     "description"
    t.string   "emails",      limit: 255, default: [], null: false, array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "kind",                                      null: false
    t.decimal  "location_lat"
    t.decimal  "location_lng"
    t.integer  "likes_count",                  default: 0,  null: false
    t.integer  "comments_count",               default: 0,  null: false
    t.integer  "old_id"
    t.integer  "status"
    t.text     "brief"
    t.boolean  "no_html_clearing"
    t.integer  "item_id"
    t.string   "item_type",        limit: 255
    t.string   "slug",             limit: 255,              null: false
    t.json     "video",                        default: {}
    t.json     "link_content",                 default: {}
    t.integer  "rating",                       default: 0,  null: false
    t.json     "videos",                       default: [],              array: true
    t.string   "from"
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "feedbacks", force: :cascade do |t|
    t.string "name",  limit: 255, null: false
    t.string "phone", limit: 255, null: false
    t.string "email", limit: 255, null: false
    t.text   "text",              null: false
  end

  create_table "followings", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "item_type",  limit: 255
  end

  add_index "followings", ["item_id"], name: "index_followings_on_item_id", using: :btree
  add_index "followings", ["user_id"], name: "index_followings_on_user_id", using: :btree

  create_table "friendship_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "recipient_id"
    t.boolean  "processed",    default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendship_requests", ["recipient_id", "processed"], name: "index_friendship_requests_on_recipient_id_and_processed", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "title",       limit: 255, null: false
    t.text     "description"
    t.integer  "user_id",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",        limit: 255, null: false
    t.integer  "status"
  end

  add_index "groups", ["user_id"], name: "index_groups_on_user_id", using: :btree

  create_table "groups_users", id: false, force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups_users", ["group_id"], name: "index_groups_users_on_group_id", using: :btree
  add_index "groups_users", ["user_id"], name: "index_groups_users_on_user_id", using: :btree

  create_table "history_stat_links", force: :cascade do |t|
    t.string   "name",                           null: false
    t.integer  "status",         default: 0
    t.integer  "integer",        default: 0
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source"
    t.string   "popup_message"
    t.integer  "clicks_count",   default: 0,     null: false
    t.boolean  "authentication", default: false, null: false
  end

  create_table "incoming_flow_events", force: :cascade do |t|
    t.datetime "nearest_event"
    t.datetime "arrival_at"
    t.integer  "site_stat"
    t.integer  "segment"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "type",          null: false
    t.integer  "item_id",       null: false
    t.text     "item_type",     null: false
  end

  add_index "incoming_flow_events", ["item_id", "item_type"], name: "index_incoming_flow_events_on_item_id_and_item_type", using: :btree

  create_table "invested_projects", force: :cascade do |t|
    t.json     "info",                default: {}
    t.integer  "project_id"
    t.integer  "position"
    t.text     "image"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.boolean  "hide_investment_sum", default: true
  end

  create_table "investment_funds", force: :cascade do |t|
    t.string   "logo",                  limit: 255
    t.string   "background",            limit: 255
    t.string   "name",                  limit: 255
    t.text     "description"
    t.string   "website",               limit: 255
    t.string   "phone",                 limit: 255
    t.string   "email",                 limit: 255
    t.integer  "sectors",                           default: [], null: false, array: true
    t.integer  "stages",                            default: [], null: false, array: true
    t.integer  "interesting_stages",                default: [],              array: true
    t.integer  "min_interest_to_share"
    t.integer  "investing_in",                      default: [],              array: true
    t.integer  "preferred_output",                  default: [],              array: true
    t.integer  "term_investments"
    t.integer  "expected_return"
    t.integer  "min_investment_size"
    t.integer  "max_investment_size"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "slug",                  limit: 255
    t.integer  "activity",                          default: 1,  null: false
  end

  create_table "investment_suggestions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "share_value",    null: false
    t.decimal  "proposed_share", null: false
    t.integer  "currency",       null: false
  end

  add_index "investment_suggestions", ["project_id"], name: "index_investment_suggestions_on_project_id", using: :btree
  add_index "investment_suggestions", ["user_id"], name: "index_investment_suggestions_on_user_id", using: :btree

  create_table "investments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "project_id"
    t.text    "title"
    t.text    "description"
    t.string  "image",              limit: 255
    t.string  "year_of_investment", limit: 255
    t.string  "current_status",     limit: 255
  end

  add_index "investments", ["project_id"], name: "index_investments_on_project_id", using: :btree
  add_index "investments", ["user_id"], name: "index_investments_on_user_id", using: :btree

  create_table "investor_test_passes", force: :cascade do |t|
    t.integer "answers", null: false, array: true
    t.integer "user_id", null: false
  end

  add_index "investor_test_passes", ["user_id"], name: "index_investor_test_passes_on_user_id", using: :btree

  create_table "invites", force: :cascade do |t|
    t.integer  "user_id",                null: false
    t.integer  "item_id",                null: false
    t.string   "item_type",  limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "state"
  end

  add_index "invites", ["item_id", "item_type"], name: "index_invites_on_item_id_and_item_type", using: :btree

  create_table "likes", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid     "user_id",    null: false
    t.uuid     "rating_id",  null: false
  end

  add_index "likes", ["rating_id", "user_id"], name: "index_likes_on_rating_id_and_user_id", unique: true, using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "mail_chimp_synchronization_logs", force: :cascade do |t|
    t.text     "result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meet_partners", force: :cascade do |t|
    t.integer "meet_id",                    null: false
    t.integer "partner_id",                 null: false
    t.boolean "organizer",  default: false
    t.integer "position"
  end

  create_table "meet_projects", force: :cascade do |t|
    t.string   "logo",               limit: 255
    t.string   "name"
    t.string   "url"
    t.string   "description"
    t.string   "avatar",             limit: 255
    t.string   "member"
    t.string   "member_description"
    t.integer  "meet_id",                        null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "position"
  end

  create_table "meet_requests", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "fullname"
    t.text     "email"
    t.text     "phone"
    t.text     "investment_size"
    t.boolean  "experience"
    t.integer  "interesting_sectors", default: [],                 array: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "meet_id"
    t.json     "project_info",        default: {}
    t.integer  "arrangement_id"
    t.boolean  "confirmed",           default: false, null: false
    t.integer  "source",                              null: false
    t.integer  "going"
    t.hstore   "additional_info",     default: {}
    t.text     "custom_sectors",      default: [],    null: false, array: true
  end

  add_index "meet_requests", ["arrangement_id"], name: "index_meet_requests_on_arrangement_id", using: :btree

  create_table "meet_statistics", force: :cascade do |t|
    t.date     "date",                   null: false
    t.integer  "show",       default: 0
    t.integer  "request",    default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "meet_id"
  end

  create_table "meeting_suggestions", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "meeting_suggestions", ["project_id"], name: "index_meeting_suggestions_on_project_id", using: :btree
  add_index "meeting_suggestions", ["user_id"], name: "index_meeting_suggestions_on_user_id", using: :btree

  create_table "meets", force: :cascade do |t|
    t.datetime "date",                                          null: false
    t.string   "map",               limit: 255
    t.string   "address"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.boolean  "active",                        default: false, null: false
    t.string   "subdomain",                                     null: false
    t.string   "title"
    t.text     "description"
    t.text     "keywords"
    t.text     "js_service_code"
    t.text     "main_image"
    t.json     "additional_fields",             default: {}
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id",                                     null: false
    t.integer  "recipient_id",                                null: false
    t.text     "body"
    t.string   "conversation_id", limit: 255,                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file",            limit: 255
    t.boolean  "read",                        default: false, null: false
  end

  add_index "messages", ["recipient_id"], name: "index_messages_on_recipient_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "metric_access_mails", force: :cascade do |t|
    t.integer  "project_metric_ids", default: [],    null: false, array: true
    t.boolean  "sent",               default: false, null: false
    t.datetime "send_at",                            null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "user_id",                            null: false
  end

  add_index "metric_access_mails", ["user_id"], name: "index_metric_access_mails_on_user_id", using: :btree

  create_table "metric_access_requests", force: :cascade do |t|
    t.boolean  "processed",         default: false, null: false
    t.integer  "user_id",                           null: false
    t.integer  "project_metric_id",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "metric_access_requests", ["project_metric_id"], name: "index_metric_access_requests_on_project_metric_id", using: :btree
  add_index "metric_access_requests", ["user_id"], name: "index_metric_access_requests_on_user_id", using: :btree

  create_table "metric_accesses", force: :cascade do |t|
    t.integer  "user_ids",          default: [],    null: false, array: true
    t.boolean  "available",         default: false, null: false
    t.integer  "project_metric_id",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "metric_accesses", ["project_metric_id"], name: "index_metric_accesses_on_project_metric_id", using: :btree

  create_table "metric_points", force: :cascade do |t|
    t.date     "timestamp",                                  null: false
    t.integer  "project_metric_id",                          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "week"
    t.decimal  "value",             precision: 30, scale: 4
    t.decimal  "expected_value",    precision: 30, scale: 4
    t.integer  "user_id"
    t.integer  "old_id"
  end

  add_index "metric_points", ["project_metric_id"], name: "index_metric_points_on_project_metric_id", using: :btree

  create_table "metric_units", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "metric_uploads", force: :cascade do |t|
    t.string   "file",       limit: 255,                 null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "processed",              default: false, null: false
    t.integer  "project_id"
  end

  add_index "metric_uploads", ["user_id"], name: "index_metric_uploads_on_user_id", using: :btree

  create_table "metrics", force: :cascade do |t|
    t.string   "name",           limit: 255, null: false
    t.integer  "metric_unit_id",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "metrics", ["metric_unit_id"], name: "index_metrics_on_metric_unit_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_ids",                            array: true
    t.json     "info"
    t.string   "type",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offers", force: :cascade do |t|
    t.integer  "old_id"
    t.integer  "status"
    t.integer  "sum"
    t.decimal  "share"
    t.integer  "currency"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "offers", ["project_id"], name: "index_offers_on_project_id", using: :btree
  add_index "offers", ["user_id"], name: "index_offers_on_user_id", using: :btree

  create_table "organisations", force: :cascade do |t|
    t.string  "name",                limit: 255
    t.string  "slug",                limit: 255
    t.string  "logo",                limit: 255
    t.text    "description"
    t.integer "min_investment_size"
    t.integer "max_investment_size"
    t.integer "city_id"
    t.integer "region_id"
    t.integer "country_id"
    t.date    "updated_at"
    t.date    "created_at"
    t.integer "kind"
    t.integer "services",                        default: [], array: true
    t.integer "markets",                         default: [], array: true
    t.integer "stages",                          default: [], array: true
    t.integer "sectors",                         default: [], array: true
    t.integer "jurisdictions",                   default: [], array: true
  end

  create_table "organisations_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "organisation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_changes", force: :cascade do |t|
    t.integer  "interval",   null: false
    t.text     "from",       null: false
    t.text     "to",         null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pages", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "body",       null: false
    t.text     "slug",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "title",      null: false
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true, using: :btree

  create_table "pair_generations", force: :cascade do |t|
    t.integer  "project_id",                null: false
    t.integer  "investor_id",               null: false
    t.integer  "lead_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "investor_type",             null: false
    t.integer  "status",        default: 0, null: false
  end

  add_index "pair_generations", ["investor_id", "created_at"], name: "index_pair_generations_on_investor_id_and_created_at", using: :btree
  add_index "pair_generations", ["investor_id", "project_id"], name: "index_pair_generations_on_investor_id_and_project_id", using: :btree

  create_table "participants", force: :cascade do |t|
    t.integer  "participants_list_id", null: false
    t.text     "name"
    t.text     "surname"
    t.text     "photo"
    t.text     "description"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "participants_lists", force: :cascade do |t|
    t.text     "title"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "partners", force: :cascade do |t|
    t.string   "logo",       limit: 255
    t.string   "url"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.json     "info",                   default: {}
    t.boolean  "on_home",                default: false
    t.integer  "position"
  end

  create_table "payment_clients", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "payer_id"
    t.integer  "amount"
    t.string   "api_status"
    t.string   "order_id",         default: "uuid_generate_v4()"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "payer_type"
    t.integer  "payable_id"
    t.string   "payable_type"
    t.float    "bank_commission",  default: 0.0
    t.integer  "lot_price",        default: 0
    t.datetime "operation_date"
    t.boolean  "checked",          default: false,                null: false
    t.string   "order_number"
    t.integer  "payment_way",      default: 0
    t.string   "description"
    t.datetime "transaction_date"
    t.boolean  "checking_account", default: false
  end

  create_table "persistent_messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "status"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",       limit: 255
    t.string   "item_type",  limit: 255
    t.integer  "item_id"
  end

  add_index "persistent_messages", ["user_id"], name: "index_persistent_messages_on_user_id", using: :btree

  create_table "popular_projects", force: :cascade do |t|
    t.integer "project_id"
  end

  create_table "project_achievements", force: :cascade do |t|
    t.string   "title",       limit: 255, null: false
    t.text     "description"
    t.string   "url",         limit: 255
    t.integer  "source"
    t.integer  "project_id",              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_achievements", ["project_id"], name: "index_project_achievements_on_project_id", using: :btree

  create_table "project_advisers", force: :cascade do |t|
    t.integer  "project_id",  null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "name"
    t.text     "description"
  end

  add_index "project_advisers", ["project_id"], name: "index_project_advisers_on_project_id", using: :btree
  add_index "project_advisers", ["user_id"], name: "index_project_advisers_on_user_id", using: :btree

  create_table "project_images", force: :cascade do |t|
    t.string   "image",      limit: 255
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "cover",                  default: false
  end

  create_table "project_investor_feedbacks", force: :cascade do |t|
    t.text     "body",                   null: false
    t.boolean  "positive",               null: false
    t.integer  "project_id",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",       limit: 255
    t.integer  "user_id"
  end

  add_index "project_investor_feedbacks", ["project_id"], name: "index_project_investor_feedbacks_on_project_id", using: :btree
  add_index "project_investor_feedbacks", ["user_id"], name: "index_project_investor_feedbacks_on_user_id", using: :btree

  create_table "project_investors", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_investors", ["project_id"], name: "index_project_investors_on_project_id", using: :btree
  add_index "project_investors", ["user_id"], name: "index_project_investors_on_user_id", using: :btree

  create_table "project_memberships", force: :cascade do |t|
    t.string   "position",                 limit: 255,                 null: false
    t.text     "achievements"
    t.string   "cv",                       limit: 255
    t.integer  "project_id",                                           null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "share"
    t.text     "name"
    t.boolean  "founder",                              default: false
    t.boolean  "can_edit_project_profile",             default: false
    t.boolean  "can_negotiate",                        default: false
  end

  add_index "project_memberships", ["project_id"], name: "index_project_memberships_on_project_id", using: :btree
  add_index "project_memberships", ["user_id"], name: "index_project_memberships_on_user_id", using: :btree

  create_table "project_metrics", force: :cascade do |t|
    t.integer  "project_id",                 null: false
    t.integer  "metric_id",                  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "app_craft",  default: false, null: false
    t.integer  "position",                   null: false
  end

  add_index "project_metrics", ["metric_id"], name: "index_project_metrics_on_metric_id", using: :btree
  add_index "project_metrics", ["project_id"], name: "index_project_metrics_on_project_id", using: :btree

  create_table "project_signals", force: :cascade do |t|
    t.text     "body",                   null: false
    t.integer  "user_id",                null: false
    t.integer  "project_id",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "timestamp"
    t.string   "link",       limit: 255
  end

  add_index "project_signals", ["project_id"], name: "index_project_signals_on_project_id", using: :btree
  add_index "project_signals", ["user_id"], name: "index_project_signals_on_user_id", using: :btree

  create_table "project_statuses", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "comment"
  end

  add_index "project_statuses", ["project_id"], name: "index_project_statuses_on_project_id", using: :btree
  add_index "project_statuses", ["user_id"], name: "index_project_statuses_on_user_id", using: :btree

  create_table "project_target_beliefs", force: :cascade do |t|
    t.integer  "kind",           null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "user_id",        null: false
    t.integer  "target_item_id", null: false
  end

  add_index "project_target_beliefs", ["target_item_id", "user_id"], name: "index_project_target_beliefs_on_target_item_id_and_user_id", unique: true, using: :btree

  create_table "project_target_items", force: :cascade do |t|
    t.text     "body",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "target_id",  null: false
  end

  add_index "project_target_items", ["target_id"], name: "index_project_target_items_on_target_id", using: :btree

  create_table "project_targets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "project_id", null: false
    t.integer  "period",     null: false
    t.date     "changed_at", null: false
  end

  add_index "project_targets", ["project_id"], name: "index_project_targets_on_project_id", using: :btree

  create_table "project_videos", force: :cascade do |t|
    t.json     "video",      default: {},    null: false
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "cover",      default: false
  end

  create_table "project_views", force: :cascade do |t|
    t.datetime "timestamp",  null: false
    t.integer  "project_id", null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_views", ["project_id"], name: "index_project_views_on_project_id", using: :btree
  add_index "project_views", ["user_id"], name: "index_project_views_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "title",                                limit: 255,                 null: false
    t.text     "description"
    t.string   "url",                                  limit: 255
    t.integer  "stage"
    t.string   "slug",                                 limit: 255,                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",                                           default: 2
    t.integer  "acceleration_type"
    t.integer  "accelerator_id"
    t.text     "idea"
    t.text     "target_group"
    t.boolean  "need_investment"
    t.date     "application_time"
    t.integer  "application_creator_id"
    t.integer  "unique_users_by_month"
    t.integer  "acceleration_status"
    t.decimal  "proposed_share"
    t.integer  "share_value_original"
    t.integer  "currency"
    t.boolean  "show_frii_role"
    t.text     "video_code"
    t.integer  "investment_size"
    t.integer  "old_id"
    t.date     "accelerator_submission_created_at"
    t.text     "market_potential"
    t.text     "resource_requirements"
    t.text     "investment_usage"
    t.text     "market_growth_rate"
    t.text     "demo_url"
    t.text     "received_investment_investor"
    t.text     "business_area"
    t.text     "revenue_expenditure_structure"
    t.integer  "followings_count",                                 default: 0,     null: false
    t.integer  "jurisdiction"
    t.integer  "market"
    t.integer  "share_value"
    t.integer  "sectors",                                          default: [],    null: false, array: true
    t.string   "logo",                                 limit: 255
    t.string   "rsr_uid",                              limit: 255
    t.string   "rsr_index",                            limit: 255
    t.string   "short_description",                    limit: 200
    t.string   "background",                           limit: 255
    t.integer  "syndicate_size"
    t.integer  "received_investment"
    t.integer  "market_size"
    t.integer  "funding_status"
    t.integer  "frii_investment_size"
    t.integer  "earnings_6_months"
    t.integer  "earnings_growth_percent_6_months"
    t.integer  "unique_users_growth_percent_6_months"
    t.integer  "app_craft_id"
    t.string   "app_url",                              limit: 255
    t.integer  "head_office_city_id"
    t.text     "geography"
    t.date     "founded_at"
    t.integer  "development_stage"
    t.json     "client_portraits",                                 default: [],    null: false
    t.text     "problem"
    t.text     "product"
    t.text     "how_business_works"
    t.text     "monetization"
    t.json     "channels_to_attract_customers",                    default: [],    null: false
    t.json     "partners_and_suppliers",                           default: [],    null: false
    t.json     "competitors_and_substitutes",                      default: [],    null: false
    t.text     "market_evaluation"
    t.text     "entity_name"
    t.text     "regalia"
    t.json     "outsources",                                       default: [],    null: false
    t.text     "attracted_investments"
    t.integer  "share_capital"
    t.integer  "left_after_five_months"
    t.json     "registered_patents",                               default: [],    null: false
    t.json     "services_and_techs",                               default: [],    null: false
    t.json     "propery_and_capital_goods",                        default: [],    null: false
    t.boolean  "ready_to_syndicate",                               default: false, null: false
    t.integer  "max_syndicate_members_count"
    t.integer  "syndicate_member_types",                           default: [],    null: false, array: true
    t.text     "investors_meeting_calendar"
    t.text     "plans_on_borrowed_investments"
    t.json     "required_resources",                               default: [],    null: false
    t.text     "success_prerequisite"
    t.text     "three_reasons_to_invest"
    t.text     "problems"
    t.text     "threats"
    t.text     "tax_reporting"
    t.text     "received_loans"
    t.text     "debts"
    t.boolean  "accelerator_frii",                                 default: false, null: false
    t.integer  "frii_selection_number"
    t.date     "runaway"
    t.date     "bep"
    t.integer  "investment_tools",                                 default: [],                 array: true
    t.integer  "market_groups",                                    default: [],                 array: true
    t.integer  "owner_id"
    t.string   "app_ios_url",                          limit: 255
    t.string   "app_android_url",                      limit: 255
    t.string   "app_windows_url",                      limit: 255
    t.datetime "version_time"
    t.integer  "version_author_id"
    t.date     "last_metrics_update"
    t.text     "assessment_base"
    t.datetime "published_at"
    t.integer  "min_investment_sum"
    t.integer  "conclusion_security",                              default: 0
    t.text     "conclusion_comment"
    t.date     "conclusion_date"
    t.decimal  "filling"
    t.boolean  "invested",                                         default: false
    t.integer  "lead_investor_id"
    t.hstore   "email_response_details",                           default: {}
    t.integer  "investment_type",                                  default: 0,     null: false
    t.text     "lot_description"
    t.datetime "contract_signing_date"
    t.string   "contract_number"
    t.datetime "contract_expiration_date"
    t.boolean  "contract_prolongation",                            default: false, null: false
    t.datetime "contract_termination_date"
    t.text     "contract_special_notes"
    t.float    "lot_share_value",                                  default: 0.0
    t.integer  "position"
    t.boolean  "accreditation_request_sent",                       default: false, null: false
  end

  add_index "projects", ["owner_id"], name: "index_projects_on_owner_id", using: :btree

  create_table "projects_selections", force: :cascade do |t|
    t.text     "title",                    null: false
    t.text     "description"
    t.integer  "status",      default: 0,  null: false
    t.text     "background"
    t.text     "slug",                     null: false
    t.integer  "project_ids", default: [], null: false, array: true
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "projects_selections", ["status"], name: "index_projects_selections_on_status", using: :btree

  create_table "promo_blocks", force: :cascade do |t|
    t.json     "info",       default: {}
    t.boolean  "active",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "push_notifications", force: :cascade do |t|
    t.text     "type",                    null: false
    t.json     "info",       default: {}, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

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
    t.integer  "image_width"
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
    t.text     "words",              default: [], null: false, array: true
    t.uuid     "recommendations",    default: [], null: false, array: true
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

  create_table "regions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "regions", ["country_id"], name: "index_regions_on_country_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.integer  "status"
    t.integer  "week_num"
    t.datetime "tracked_at"
    t.integer  "estimate"
    t.text     "body"
    t.integer  "old_id"
    t.boolean  "no_html_clearing"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reports", ["project_id"], name: "index_reports_on_project_id", using: :btree
  add_index "reports", ["user_id"], name: "index_reports_on_user_id", using: :btree

  create_table "road_map_points", force: :cascade do |t|
    t.text     "body",                   null: false
    t.string   "image",      limit: 255
    t.date     "date",                   null: false
    t.integer  "project_id",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "road_map_points", ["project_id"], name: "index_road_map_points_on_project_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.integer  "kind",                                   null: false
    t.integer  "user_id",                                null: false
    t.integer  "scope_id"
    t.string   "scope_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmed",              default: false, null: false
  end

  add_index "roles", ["kind"], name: "index_roles_on_kind", using: :btree
  add_index "roles", ["scope_id", "scope_type"], name: "index_roles_on_scope_id_and_scope_type", using: :btree
  add_index "roles", ["user_id"], name: "index_roles_on_user_id", using: :btree

  create_table "rpush_apps", force: :cascade do |t|
    t.string   "name",                                null: false
    t.string   "environment"
    t.text     "certificate"
    t.string   "password"
    t.integer  "connections",             default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",                                null: false
    t.string   "auth_key"
    t.string   "client_id"
    t.string   "client_secret"
    t.string   "access_token"
    t.datetime "access_token_expiration"
  end

  create_table "rpush_feedback", force: :cascade do |t|
    t.string   "device_token", limit: 64, null: false
    t.datetime "failed_at",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "app_id"
  end

  add_index "rpush_feedback", ["device_token"], name: "index_rpush_feedback_on_device_token", using: :btree

  create_table "rpush_notifications", force: :cascade do |t|
    t.integer  "badge"
    t.string   "device_token",      limit: 64
    t.string   "sound",                        default: "default"
    t.string   "alert"
    t.text     "data"
    t.integer  "expiry",                       default: 86400
    t.boolean  "delivered",                    default: false,     null: false
    t.datetime "delivered_at"
    t.boolean  "failed",                       default: false,     null: false
    t.datetime "failed_at"
    t.integer  "error_code"
    t.text     "error_description"
    t.datetime "deliver_after"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "alert_is_json",                default: false
    t.string   "type",                                             null: false
    t.string   "collapse_key"
    t.boolean  "delay_while_idle",             default: false,     null: false
    t.text     "registration_ids"
    t.integer  "app_id",                                           null: false
    t.integer  "retries",                      default: 0
    t.string   "uri"
    t.datetime "fail_after"
    t.boolean  "processing",                   default: false,     null: false
    t.integer  "priority"
    t.text     "url_args"
    t.string   "category"
  end

  add_index "rpush_notifications", ["delivered", "failed"], name: "index_rpush_notifications_multi", where: "((NOT delivered) AND (NOT failed))", using: :btree

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
    t.text     "inverted_color",               null: false
  end

  add_index "sections", ["slug"], name: "index_sections_on_slug", unique: true, using: :btree

  create_table "slides", force: :cascade do |t|
    t.integer  "kind",           default: 0
    t.integer  "position"
    t.json     "info",           default: {}
    t.text     "image"
    t.integer  "slideable_id"
    t.string   "slideable_type"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "active"
  end

  add_index "slides", ["slideable_type", "slideable_id"], name: "index_slides_on_slideable_type_and_slideable_id", using: :btree

  create_table "sms_authentication_sessions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "email_token"
    t.string   "sms_code"
    t.boolean  "token_active", default: false, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "sms_subscriptions", force: :cascade do |t|
    t.json     "info",       default: {}, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "user_id",                 null: false
  end

  add_index "sms_subscriptions", ["user_id"], name: "index_sms_subscriptions_on_user_id", unique: true, using: :btree

  create_table "speed_date_events", force: :cascade do |t|
    t.integer  "speed_date_id"
    t.string   "user"
    t.string   "project"
    t.datetime "start_at"
    t.datetime "stop_at"
    t.boolean  "finished",      default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "speed_dates", force: :cascade do |t|
    t.text     "projects"
    t.text     "users"
    t.datetime "start_at"
    t.integer  "step"
  end

  create_table "stat_link_requests", force: :cascade do |t|
    t.integer  "from",          default: 0
    t.integer  "user_id"
    t.string   "source"
    t.integer  "item_id"
    t.string   "item_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "bulk_email_id"
    t.string   "email"
  end

  create_table "stat_links", force: :cascade do |t|
    t.json     "data",                 default: {}
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "history_stat_link_id"
    t.string   "email"
    t.integer  "bulk_email_id"
  end

  add_index "stat_links", ["history_stat_link_id"], name: "index_stat_links_on_history_stat_link_id", using: :btree

  create_table "static_images", force: :cascade do |t|
    t.text "file"
  end

  create_table "syndicate_investor_exits", force: :cascade do |t|
    t.integer "syndicate_id"
    t.string  "date_field",     limit: 255
    t.integer "tranche_number"
  end

  add_index "syndicate_investor_exits", ["syndicate_id"], name: "index_syndicate_investor_exits_on_syndicate_id", using: :btree

  create_table "syndicate_investor_sharing_currencies", force: :cascade do |t|
    t.integer "syndicate_id"
    t.string  "name",              limit: 255
    t.integer "value"
    t.integer "currency_variant"
    t.integer "exchange_variant"
    t.string  "text_value",        limit: 255
    t.integer "not_more_than_rub"
    t.integer "not_less_than_rub"
    t.integer "fixed_rate"
  end

  add_index "syndicate_investor_sharing_currencies", ["syndicate_id"], name: "index_syndicate_investor_sharing_currencies_on_syndicate_id", using: :btree

  create_table "syndicate_kpis", force: :cascade do |t|
    t.integer "tranche_id"
    t.integer "variant"
    t.integer "payment"
    t.integer "agreements"
    t.integer "visits"
  end

  add_index "syndicate_kpis", ["tranche_id"], name: "index_syndicate_kpis_on_tranche_id", using: :btree

  create_table "syndicate_nominal_prices", force: :cascade do |t|
    t.integer "syndicate_id"
    t.integer "value"
    t.string  "text_value",   limit: 255
    t.string  "member_name",  limit: 255
  end

  add_index "syndicate_nominal_prices", ["syndicate_id"], name: "index_syndicate_nominal_prices_on_syndicate_id", using: :btree

  create_table "syndicate_options", force: :cascade do |t|
    t.integer "target_id"
    t.string  "target_type",   limit: 255
    t.integer "question"
    t.integer "variant"
    t.integer "value"
    t.string  "other_variant", limit: 255
  end

  create_table "syndicate_tranches", force: :cascade do |t|
    t.integer "syndicate_id"
    t.integer "variant"
    t.integer "payment"
    t.string  "limit_date",    limit: 255
    t.integer "number"
    t.text    "other_variant"
  end

  add_index "syndicate_tranches", ["syndicate_id"], name: "index_syndicate_tranches_on_syndicate_id", using: :btree

  create_table "syndicates", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "investment_realization"
    t.integer  "instead_of_investment"
    t.integer  "joint"
    t.boolean  "is_ipo_soon"
    t.integer  "deadlock_condition"
    t.string   "not_sale_date",                      limit: 255
    t.integer  "not_sale_tranche_number"
    t.boolean  "is_have_directors"
    t.integer  "approval_currency_value"
    t.string   "approval_currency_text",             limit: 255
    t.integer  "investor_access_variant"
    t.integer  "min_authority_members"
    t.integer  "max_authority_members"
    t.boolean  "is_profit_prohibition"
    t.string   "profit_prohibition_date",            limit: 255
    t.integer  "profit_prohibition_tranche_number"
    t.boolean  "is_exit_prohibition"
    t.string   "exit_prohibition_date",              limit: 255
    t.integer  "exit_prohibition_tranche_number"
    t.boolean  "is_can_sale_parts"
    t.integer  "capital_size_value"
    t.string   "capital_size_text",                  limit: 255
    t.integer  "percent_size_value"
    t.string   "percent_size_text",                  limit: 255
    t.integer  "directors_jurisdictions",                        default: [], null: false, array: true
    t.integer  "approval_deals",                                 default: [], null: false, array: true
    t.integer  "key_workers",                                    default: [], null: false, array: true
    t.integer  "investor_access_rights",                         default: [], null: false, array: true
    t.integer  "investor_access_create_managements",             default: [], null: false, array: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "investment_order_variant"
    t.string   "investment_order_limit_date",        limit: 255
    t.string   "opinion",                            limit: 255
    t.string   "other_investment_realization",       limit: 255
    t.string   "other_investment_order",             limit: 255
    t.string   "other_additional_condition",         limit: 255
    t.string   "other_deadlock_condition",           limit: 255
    t.string   "other_directors_jurisdiction",       limit: 255
    t.string   "other_approval_deal",                limit: 255
    t.string   "other_key_worker",                   limit: 255
    t.string   "company_name",                       limit: 255
    t.string   "investor_access_other_variant",      limit: 255
    t.boolean  "no_additional_condition"
    t.integer  "additional_conditions",                          default: [], null: false, array: true
  end

  add_index "syndicates", ["user_id"], name: "index_syndicates_on_user_id", using: :btree

  create_table "tags", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.text     "name",                      null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "ratings_count", default: 0, null: false
    t.text     "slug",                      null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree
  add_index "tags", ["slug"], name: "index_tags_on_slug", unique: true, using: :btree

  create_table "tags_items", force: :cascade do |t|
    t.integer  "tag_id",                 null: false
    t.integer  "item_id",                null: false
    t.string   "item_type",  limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags_items", ["item_id", "item_type"], name: "index_tags_items_on_item_id_and_item_type", using: :btree
  add_index "tags_items", ["tag_id"], name: "index_tags_items_on_tag_id", using: :btree

  create_table "transaction_payments", force: :cascade do |t|
    t.decimal  "amount"
    t.decimal  "original_amount"
    t.decimal  "original_amount_currency"
    t.decimal  "original_amount_conversion_ratio"
    t.integer  "position"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "transaction_id",                   null: false
  end

  add_index "transaction_payments", ["transaction_id"], name: "index_transaction_payments_on_transaction_id", using: :btree

  create_table "transactions", force: :cascade do |t|
    t.integer  "stage"
    t.integer  "kind"
    t.date     "signed_at"
    t.date     "payed_at"
    t.date     "invoiced_at"
    t.date     "commission_paid_at"
    t.decimal  "amount"
    t.decimal  "original_amount"
    t.decimal  "original_amount_currency"
    t.decimal  "original_amount_conversion_ratio"
    t.decimal  "commission_percent"
    t.decimal  "commission_amount"
    t.text     "project_agent"
    t.decimal  "project_agent_commission"
    t.text     "investor_agent"
    t.decimal  "investor_agent_commission"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "project_id"
    t.integer  "investor_id"
    t.integer  "deal_creator_id",                  null: false
  end

  add_index "transactions", ["deal_creator_id"], name: "index_transactions_on_deal_creator_id", using: :btree
  add_index "transactions", ["investor_id"], name: "index_transactions_on_investor_id", using: :btree
  add_index "transactions", ["project_id"], name: "index_transactions_on_project_id", using: :btree

  create_table "user_accesses", force: :cascade do |t|
    t.integer  "user_ids",   default: [], null: false, array: true
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.json     "reasons",    default: {}, null: false
  end

  add_index "user_accesses", ["user_id"], name: "index_user_accesses_on_user_id", using: :btree
  add_index "user_accesses", ["user_ids"], name: "index_user_accesses_on_user_ids", using: :btree

  create_table "user_actions", force: :cascade do |t|
    t.string   "type",       limit: 255,              null: false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "info",                   default: {}, null: false
  end

  add_index "user_actions", ["user_id"], name: "index_user_actions_on_user_id", using: :btree

  create_table "user_agreements", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "surname",         limit: 255
    t.string   "patronymic",      limit: 255
    t.integer  "passport_number"
    t.integer  "passport_series"
    t.text     "passport_issued"
    t.datetime "passport_date"
    t.text     "address"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_agreements", ["user_id"], name: "index_user_agreements_on_user_id", using: :btree

  create_table "user_notes", force: :cascade do |t|
    t.text     "body",       null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id",    null: false
    t.integer  "author_id",  null: false
    t.integer  "deleter_id"
  end

  add_index "user_notes", ["author_id"], name: "index_user_notes_on_author_id", using: :btree
  add_index "user_notes", ["deleted_at"], name: "index_user_notes_on_deleted_at", using: :btree
  add_index "user_notes", ["deleter_id"], name: "index_user_notes_on_deleter_id", using: :btree
  add_index "user_notes", ["user_id"], name: "index_user_notes_on_user_id", using: :btree

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

  create_table "validation_errors", force: :cascade do |t|
    t.text     "object"
    t.text     "messages"
    t.text     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",    limit: 255, null: false
    t.integer  "item_id",                  null: false
    t.string   "event",        limit: 255, null: false
    t.string   "whodunnit",    limit: 255
    t.binary   "object"
    t.datetime "created_at"
    t.datetime "version_time"
    t.integer  "author_id"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "votes", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "kind",           null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.uuid     "user_id",        null: false
    t.uuid     "rating_item_id", null: false
  end

  add_index "votes", ["rating_item_id"], name: "index_votes_on_rating_item_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

  add_foreign_key "accreditation_requests", "roles", name: "accreditation_requests_role_id_fk"
  add_foreign_key "authentications", "users"
  add_foreign_key "banner_clicks", "banners"
  add_foreign_key "browser_notification_subscriptions", "users"
  add_foreign_key "browser_notification_subscriptions", "users"
  add_foreign_key "cities", "regions", name: "cities_region_id_fk"
  add_foreign_key "coinvestors", "projects", name: "coinvestors_project_id_fk"
  add_foreign_key "comments", "comments", column: "parent_id"
  add_foreign_key "comments", "ratings"
  add_foreign_key "comments", "users"
  add_foreign_key "comments", "users", name: "comments_user_id_fk"
  add_foreign_key "crowd_document_templates", "projects"
  add_foreign_key "crowd_investment_documents", "projects"
  add_foreign_key "crowdlending_payments", "crowdlending_deals"
  add_foreign_key "groups_users", "groups", name: "groups_users_group_id_fk"
  add_foreign_key "likes", "ratings"
  add_foreign_key "likes", "users"
  add_foreign_key "likes", "users", name: "likes_user_id_fk"
  add_foreign_key "meet_partners", "meets"
  add_foreign_key "meet_partners", "partners"
  add_foreign_key "meeting_suggestions", "projects", name: "meeting_suggestions_project_id_fk"
  add_foreign_key "metric_access_requests", "project_metrics", name: "metric_access_requests_project_metric_id_fk"
  add_foreign_key "metric_accesses", "project_metrics", name: "metric_accesses_project_metric_id_fk"
  add_foreign_key "metric_points", "project_metrics", name: "metric_points_project_metric_id_fk"
  add_foreign_key "metrics", "metric_units", name: "metrics_metric_unit_id_fk"
  add_foreign_key "offers", "projects", name: "offers_project_id_fk"
  add_foreign_key "organisations_users", "organisations", name: "organisations_users_organisation_id_fk"
  add_foreign_key "project_achievements", "projects", name: "project_achievements_project_id_fk"
  add_foreign_key "project_advisers", "projects", name: "project_advisers_project_id_fk"
  add_foreign_key "project_images", "projects", name: "project_images_project_id_fk"
  add_foreign_key "project_memberships", "projects", name: "project_memberships_project_id_fk"
  add_foreign_key "project_metrics", "metrics", name: "project_metrics_metric_id_fk"
  add_foreign_key "project_metrics", "projects", name: "project_metrics_project_id_fk"
  add_foreign_key "project_signals", "projects", name: "project_signals_project_id_fk"
  add_foreign_key "project_targets", "projects"
  add_foreign_key "project_videos", "projects", name: "project_videos_project_id_fk"
  add_foreign_key "rating_items", "ratings"
  add_foreign_key "ratings", "sections"
  add_foreign_key "ratings", "users"
  add_foreign_key "ratings_tags", "ratings"
  add_foreign_key "ratings_tags", "tags"
  add_foreign_key "regions", "countries", name: "regions_country_id_fk"
  add_foreign_key "reports", "projects", name: "reports_project_id_fk"
  add_foreign_key "road_map_points", "projects", name: "road_map_points_project_id_fk"
  add_foreign_key "votes", "rating_items"
  add_foreign_key "votes", "users"
end
