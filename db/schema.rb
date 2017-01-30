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

ActiveRecord::Schema.define(version: 20170126182431) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_stat_statements"
  enable_extension "postgis"

  create_table "ar_internal_metadata", primary_key: "key", force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brands", force: :cascade do |t|
    t.text     "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "brands", ["name"], name: "index_brands_on_name", unique: true, using: :btree

  create_table "broadcasts", force: :cascade do |t|
    t.text     "title"
    t.text     "html"
    t.integer  "sender_id"
    t.integer  "message_action_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "resource_id"
    t.datetime "send_at"
    t.boolean  "sent"
    t.boolean  "send_to_all",       default: false, null: false
    t.boolean  "is_immediate",      default: false, null: false
    t.datetime "deleted_at"
    t.text     "action_text"
  end

  add_index "broadcasts", ["deleted_at"], name: "index_broadcasts_on_deleted_at", using: :btree
  add_index "broadcasts", ["message_action_id"], name: "index_broadcasts_on_message_action_id", using: :btree
  add_index "broadcasts", ["sender_id"], name: "index_broadcasts_on_sender_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.text     "name",            null: false
    t.integer  "organization_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "categories", ["organization_id", "name"], name: "index_categories_on_organization_id_and_name", unique: true, using: :btree
  add_index "categories", ["organization_id"], name: "index_categories_on_organization_id", using: :btree

  create_table "checkins", force: :cascade do |t|
    t.integer  "user_id",                                                        null: false
    t.datetime "arrival_time",                                                   null: false
    t.datetime "exit_time"
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
    t.json     "data",                                              default: {}, null: false
    t.geometry "arrival_lonlat", limit: {:srid=>0, :type=>"point"}
    t.geometry "exit_lonlat",    limit: {:srid=>0, :type=>"point"}
    t.integer  "store_id"
  end

  add_index "checkins", ["arrival_lonlat"], name: "index_checkins_on_arrival_lonlat", using: :gist
  add_index "checkins", ["exit_lonlat"], name: "index_checkins_on_exit_lonlat", using: :gist
  add_index "checkins", ["store_id"], name: "index_checkins_on_store_id", using: :btree
  add_index "checkins", ["user_id"], name: "index_checkins_on_user_id", using: :btree

  create_table "checklist_item_values", force: :cascade do |t|
    t.integer  "report_id",                 null: false
    t.boolean  "item_value"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "data_part_id",              null: false
    t.json     "image_list",   default: []
  end

  add_index "checklist_item_values", ["data_part_id"], name: "index_checklist_item_values_on_data_part_id", using: :btree
  add_index "checklist_item_values", ["report_id"], name: "index_checklist_item_values_on_report_id", using: :btree

  create_table "daily_head_counts", force: :cascade do |t|
    t.integer  "num_full_time",  default: 0, null: false
    t.integer  "num_part_time",  default: 0, null: false
    t.integer  "brand_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "report_id"
    t.integer  "num_apoyo_time", default: 0, null: false
  end

  add_index "daily_head_counts", ["brand_id"], name: "index_daily_head_counts_on_brand_id", using: :btree
  add_index "daily_head_counts", ["report_id"], name: "index_daily_head_counts_on_report_id", using: :btree

  create_table "daily_product_sales", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "quantity",   default: 0, null: false
    t.integer  "amount",     default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "report_id"
  end

  add_index "daily_product_sales", ["product_id"], name: "index_daily_product_sales_on_product_id", using: :btree
  add_index "daily_product_sales", ["report_id"], name: "index_daily_product_sales_on_report_id", using: :btree

  create_table "daily_sales", force: :cascade do |t|
    t.integer  "brand_id",                    null: false
    t.integer  "hardware_sales",  default: 0, null: false
    t.integer  "accessory_sales", default: 0, null: false
    t.integer  "game_sales",      default: 0, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "report_id"
  end

  add_index "daily_sales", ["brand_id"], name: "index_daily_sales_on_brand_id", using: :btree
  add_index "daily_sales", ["report_id"], name: "index_daily_sales_on_report_id", using: :btree

  create_table "daily_stocks", force: :cascade do |t|
    t.integer  "brand_id"
    t.integer  "report_id"
    t.integer  "hardware_sales",  limit: 8, default: 0, null: false
    t.integer  "accessory_sales", limit: 8, default: 0, null: false
    t.integer  "game_sales",      limit: 8, default: 0, null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "daily_stocks", ["brand_id"], name: "index_daily_stocks_on_brand_id", using: :btree
  add_index "daily_stocks", ["report_id"], name: "index_daily_stocks_on_report_id", using: :btree

  create_table "data_parts", force: :cascade do |t|
    t.integer  "subsection_id"
    t.text     "type",                           null: false
    t.text     "name",                           null: false
    t.text     "icon"
    t.boolean  "required",        default: true, null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "ancestry"
    t.integer  "max_images"
    t.integer  "max_length"
    t.json     "data",            default: {},   null: false
    t.integer  "position",        default: 0,    null: false
    t.integer  "detail_id"
    t.integer  "organization_id"
  end

  add_index "data_parts", ["ancestry"], name: "index_data_parts_on_ancestry", using: :btree
  add_index "data_parts", ["detail_id"], name: "index_data_parts_on_detail_id", using: :btree
  add_index "data_parts", ["organization_id"], name: "index_data_parts_on_organization_id", using: :btree
  add_index "data_parts", ["subsection_id"], name: "index_data_parts_on_subsection_id", using: :btree

  create_table "dealers", force: :cascade do |t|
    t.text     "name",         null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "contact"
    t.text     "phone_number"
    t.text     "address"
    t.datetime "deleted_at"
    t.text     "kam"
  end

  add_index "dealers", ["deleted_at"], name: "index_dealers_on_deleted_at", using: :btree
  add_index "dealers", ["name"], name: "index_dealers_on_name", unique: true, using: :btree

  create_table "dealers_promotions", id: false, force: :cascade do |t|
    t.integer "promotion_id", null: false
    t.integer "dealer_id",    null: false
  end

  add_index "dealers_promotions", ["dealer_id"], name: "index_dealers_promotions_on_dealer_id", using: :btree
  add_index "dealers_promotions", ["promotion_id"], name: "index_dealers_promotions_on_promotion_id", using: :btree

  create_table "dealers_zones", id: false, force: :cascade do |t|
    t.integer "dealer_id"
    t.integer "zone_id"
  end

  add_index "dealers_zones", ["dealer_id", "zone_id"], name: "index_dealers_zones_on_dealer_id_and_zone_id", unique: true, using: :btree

  create_table "devices", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "device_token"
    t.text     "registration_id"
    t.text     "uuid"
    t.text     "architecture"
    t.text     "address"
    t.text     "locale"
    t.text     "manufacturer"
    t.text     "model"
    t.text     "name"
    t.text     "os_name"
    t.integer  "processor_count"
    t.text     "version"
    t.text     "os_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.text     "image"
    t.integer  "data_part_id"
    t.integer  "user_id",                 null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "category_id"
    t.integer  "report_id"
    t.integer  "detail_id",     limit: 8
    t.integer  "resource_id"
    t.text     "resource_type"
    t.text     "uuid"
    t.datetime "deleted_at"
    t.text     "comment"
  end

  add_index "images", ["category_id"], name: "index_images_on_category_id", using: :btree
  add_index "images", ["data_part_id"], name: "index_images_on_data_part_id", using: :btree
  add_index "images", ["deleted_at"], name: "index_images_on_deleted_at", using: :btree
  add_index "images", ["report_id"], name: "index_images_on_report_id", using: :btree
  add_index "images", ["resource_id"], name: "index_images_on_resource_id", using: :btree
  add_index "images", ["resource_type"], name: "index_images_on_resource_type", using: :btree
  add_index "images", ["user_id"], name: "index_images_on_user_id", using: :btree

  create_table "invitations", force: :cascade do |t|
    t.integer  "role_id",                            null: false
    t.text     "confirmation_token",                 null: false
    t.text     "email",                              null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.boolean  "accepted",           default: false, null: false
  end

  add_index "invitations", ["email"], name: "index_invitations_on_email", unique: true, using: :btree
  add_index "invitations", ["role_id"], name: "index_invitations_on_role_id", using: :btree

  create_table "message_actions", force: :cascade do |t|
    t.integer  "organization_id"
    t.text     "name",            null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "message_actions", ["organization_id", "name"], name: "index_message_actions_on_organization_id_and_name", unique: true, using: :btree
  add_index "message_actions", ["organization_id"], name: "index_message_actions_on_organization_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "broadcast_id",                 null: false
    t.integer  "user_id",                      null: false
    t.boolean  "read",         default: false, null: false
    t.datetime "read_at"
    t.datetime "deleted_at"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "messages", ["broadcast_id"], name: "index_messages_on_broadcast_id", using: :btree
  add_index "messages", ["deleted_at"], name: "index_messages_on_deleted_at", using: :btree
  add_index "messages", ["read"], name: "index_messages_on_read", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "organizations", force: :cascade do |t|
    t.text     "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "organizations", ["name"], name: "index_organizations_on_name", unique: true, using: :btree

  create_table "pghero_query_stats", force: :cascade do |t|
    t.text     "database"
    t.text     "query"
    t.integer  "query_hash",  limit: 8
    t.float    "total_time"
    t.integer  "calls",       limit: 8
    t.datetime "captured_at"
  end

  add_index "pghero_query_stats", ["database", "captured_at"], name: "index_pghero_query_stats_on_database_and_captured_at", using: :btree

  create_table "platforms", force: :cascade do |t|
    t.text     "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "brand_id"
  end

  add_index "platforms", ["brand_id"], name: "index_platforms_on_brand_id", using: :btree

  create_table "product_classifications", force: :cascade do |t|
    t.text     "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_types", force: :cascade do |t|
    t.text     "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.text     "name",                                      null: false
    t.text     "description"
    t.text     "sku"
    t.text     "plu"
    t.text     "validity_code"
    t.integer  "product_type_id",                           null: false
    t.text     "brand"
    t.integer  "min_price"
    t.integer  "max_price"
    t.integer  "product_classification_id",                 null: false
    t.boolean  "is_top",                    default: false, null: false
    t.boolean  "is_listed",                 default: false, null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "platform_id"
    t.text     "publisher"
    t.string   "deleted_at"
    t.boolean  "catalogued",                default: true,  null: false
  end

  add_index "products", ["catalogued"], name: "index_products_on_catalogued", using: :btree
  add_index "products", ["deleted_at"], name: "index_products_on_deleted_at", using: :btree
  add_index "products", ["is_listed"], name: "index_products_on_is_listed", using: :btree
  add_index "products", ["name"], name: "index_products_on_name", using: :btree
  add_index "products", ["platform_id"], name: "index_products_on_platform_id", using: :btree
  add_index "products", ["plu"], name: "index_products_on_plu", unique: true, using: :btree
  add_index "products", ["product_classification_id"], name: "index_products_on_product_classification_id", using: :btree
  add_index "products", ["product_type_id"], name: "index_products_on_product_type_id", using: :btree
  add_index "products", ["sku"], name: "index_products_on_sku", unique: true, using: :btree

  create_table "promotion_states", force: :cascade do |t|
    t.integer  "promotion_id", null: false
    t.integer  "store_id",     null: false
    t.datetime "activated_at"
    t.integer  "report_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "deleted_at"
  end

  add_index "promotion_states", ["activated_at"], name: "index_promotion_states_on_activated_at", using: :btree
  add_index "promotion_states", ["deleted_at"], name: "index_promotion_states_on_deleted_at", using: :btree
  add_index "promotion_states", ["promotion_id"], name: "index_promotion_states_on_promotion_id", using: :btree
  add_index "promotion_states", ["report_id"], name: "index_promotion_states_on_report_id", using: :btree
  add_index "promotion_states", ["store_id"], name: "index_promotion_states_on_store_id", using: :btree

  create_table "promotions", force: :cascade do |t|
    t.datetime "start_date",   null: false
    t.datetime "end_date",     null: false
    t.text     "title",        null: false
    t.text     "html",         null: false
    t.integer  "checklist_id"
    t.integer  "creator_id",   null: false
    t.datetime "deleted_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "promotions", ["checklist_id"], name: "index_promotions_on_checklist_id", using: :btree
  add_index "promotions", ["creator_id"], name: "index_promotions_on_creator_id", using: :btree
  add_index "promotions", ["deleted_at"], name: "index_promotions_on_deleted_at", using: :btree

  create_table "promotions_users", id: false, force: :cascade do |t|
    t.integer "promotion_id", null: false
    t.integer "user_id",      null: false
  end

  add_index "promotions_users", ["promotion_id"], name: "index_promotions_users_on_promotion_id", using: :btree
  add_index "promotions_users", ["user_id"], name: "index_promotions_users_on_user_id", using: :btree

  create_table "promotions_zones", id: false, force: :cascade do |t|
    t.integer "promotion_id", null: false
    t.integer "zone_id",      null: false
  end

  add_index "promotions_zones", ["promotion_id"], name: "index_promotions_zones_on_promotion_id", using: :btree
  add_index "promotions_zones", ["zone_id"], name: "index_promotions_zones_on_zone_id", using: :btree

  create_table "report_types", force: :cascade do |t|
    t.text     "name"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "report_types", ["organization_id"], name: "index_report_types_on_organization_id", using: :btree

  create_table "report_types_sections", id: false, force: :cascade do |t|
    t.integer "report_type_id", null: false
    t.integer "section_id",     null: false
  end

  add_index "report_types_sections", ["report_type_id"], name: "index_report_types_sections_on_report_type_id", using: :btree
  add_index "report_types_sections", ["section_id"], name: "index_report_types_sections_on_section_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.integer  "report_type_id",                     null: false
    t.json     "dynamic_attributes", default: {},    null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "creator_id",                         null: false
    t.datetime "limit_date"
    t.boolean  "finished",           default: false, null: false
    t.text     "pdf"
    t.boolean  "pdf_uploaded",       default: false, null: false
    t.text     "uuid"
    t.integer  "store_id"
    t.datetime "deleted_at"
    t.datetime "finished_at"
    t.datetime "task_start"
    t.text     "title"
    t.text     "description"
    t.boolean  "is_task",            default: false, null: false
    t.text     "unique_id"
    t.integer  "executor_id"
  end

  add_index "reports", ["creator_id"], name: "index_reports_on_creator_id", using: :btree
  add_index "reports", ["deleted_at"], name: "index_reports_on_deleted_at", using: :btree
  add_index "reports", ["executor_id"], name: "index_reports_on_executor_id", using: :btree
  add_index "reports", ["finished"], name: "index_reports_on_finished", using: :btree
  add_index "reports", ["report_type_id"], name: "index_reports_on_report_type_id", using: :btree
  add_index "reports", ["store_id"], name: "index_reports_on_store_id", using: :btree
  add_index "reports", ["unique_id"], name: "index_reports_on_unique_id", using: :btree
  add_index "reports", ["uuid"], name: "index_reports_on_uuid", using: :btree

  create_table "reports_users", id: false, force: :cascade do |t|
    t.integer "report_id", null: false
    t.integer "user_id",   null: false
  end

  add_index "reports_users", ["report_id"], name: "index_reports_users_on_report_id", using: :btree
  add_index "reports_users", ["user_id"], name: "index_reports_users_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.integer  "organization_id", null: false
    t.text     "name",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["organization_id", "name"], name: "index_roles_on_organization_id_and_name", unique: true, using: :btree
  add_index "roles", ["organization_id"], name: "index_roles_on_organization_id", using: :btree

  create_table "sale_goal_uploads", force: :cascade do |t|
    t.text     "result_csv"
    t.text     "uploaded_csv"
    t.datetime "goal_date"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "user_id"
    t.integer  "num_errors",   default: 0, null: false
    t.integer  "num_total"
  end

  add_index "sale_goal_uploads", ["user_id"], name: "index_sale_goal_uploads_on_user_id", using: :btree

  create_table "sale_goals", force: :cascade do |t|
    t.integer  "store_id",            null: false
    t.integer  "monthly_goal",        null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.datetime "goal_date",           null: false
    t.integer  "sale_goal_upload_id"
    t.datetime "deleted_at"
  end

  add_index "sale_goals", ["deleted_at"], name: "index_sale_goals_on_deleted_at", using: :btree
  add_index "sale_goals", ["sale_goal_upload_id"], name: "index_sale_goals_on_sale_goal_upload_id", using: :btree
  add_index "sale_goals", ["store_id"], name: "index_sale_goals_on_store_id", using: :btree

  create_table "section_types", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sections", force: :cascade do |t|
    t.integer  "position"
    t.text     "name"
    t.integer  "organization_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "section_type_id", null: false
  end

  add_index "sections", ["organization_id"], name: "index_sections_on_organization_id", using: :btree
  add_index "sections", ["section_type_id"], name: "index_sections_on_section_type_id", using: :btree

  create_table "stock_break_events", force: :cascade do |t|
    t.integer  "product_id",           null: false
    t.integer  "quantity",             null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "stock_break_quantity"
    t.integer  "report_id"
  end

  add_index "stock_break_events", ["product_id"], name: "index_stock_break_events_on_product_id", using: :btree
  add_index "stock_break_events", ["report_id"], name: "index_stock_break_events_on_report_id", using: :btree

  create_table "stock_breaks", force: :cascade do |t|
    t.integer  "dealer_id"
    t.integer  "store_type_id"
    t.integer  "product_classification_id"
    t.integer  "stock_break"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.datetime "deleted_at"
  end

  add_index "stock_breaks", ["dealer_id"], name: "index_stock_breaks_on_dealer_id", using: :btree
  add_index "stock_breaks", ["product_classification_id"], name: "index_stock_breaks_on_product_classification_id", using: :btree
  add_index "stock_breaks", ["store_type_id"], name: "index_stock_breaks_on_store_type_id", using: :btree

  create_table "store_types", force: :cascade do |t|
    t.text     "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "store_types", ["name"], name: "index_store_types_on_name", unique: true, using: :btree

  create_table "stores", force: :cascade do |t|
    t.text     "name",                                     null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.text     "contact"
    t.text     "phone_number"
    t.text     "address"
    t.integer  "zone_id"
    t.integer  "dealer_id"
    t.datetime "deleted_at"
    t.integer  "monthly_goal_clp"
    t.decimal  "monthly_goal_usd", precision: 8, scale: 2
    t.integer  "store_type_id"
    t.text     "code"
    t.integer  "supervisor_id"
    t.integer  "instructor_id"
    t.text     "store_manager"
    t.text     "floor_manager"
    t.text     "visual"
    t.text     "area_salesperson"
  end

  add_index "stores", ["dealer_id"], name: "index_stores_on_dealer_id", using: :btree
  add_index "stores", ["deleted_at"], name: "index_stores_on_deleted_at", using: :btree
  add_index "stores", ["instructor_id"], name: "index_stores_on_instructor_id", using: :btree
  add_index "stores", ["name", "dealer_id", "zone_id"], name: "index_stores_on_name_and_dealer_id_and_zone_id", unique: true, using: :btree
  add_index "stores", ["store_type_id"], name: "index_stores_on_store_type_id", using: :btree
  add_index "stores", ["supervisor_id"], name: "index_stores_on_supervisor_id", using: :btree
  add_index "stores", ["zone_id"], name: "index_stores_on_zone_id", using: :btree

  create_table "stores_users", id: false, force: :cascade do |t|
    t.integer "store_id", null: false
    t.integer "user_id",  null: false
  end

  add_index "stores_users", ["store_id"], name: "index_stores_users_on_store_id", using: :btree
  add_index "stores_users", ["user_id"], name: "index_stores_users_on_user_id", using: :btree

  create_table "subsection_item_types", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subsection_items", force: :cascade do |t|
    t.integer  "subsection_item_type_id", null: false
    t.integer  "subsection_id",           null: false
    t.boolean  "has_details",             null: false
    t.text     "name",                    null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "subsection_items", ["subsection_id", "name"], name: "index_subsection_items_on_subsection_id_and_name", unique: true, using: :btree
  add_index "subsection_items", ["subsection_id"], name: "index_subsection_items_on_subsection_id", using: :btree
  add_index "subsection_items", ["subsection_item_type_id"], name: "index_subsection_items_on_subsection_item_type_id", using: :btree

  create_table "subsections", force: :cascade do |t|
    t.integer  "section_id"
    t.text     "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subsections", ["section_id"], name: "index_subsections_on_section_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.text     "rut"
    t.text     "first_name"
    t.text     "last_name"
    t.text     "phone_number"
    t.text     "address"
    t.text     "image"
    t.integer  "role_id",                             null: false
    t.datetime "deleted_at"
    t.text     "emergency_phone",        default: "", null: false
    t.datetime "contract_date"
    t.datetime "contract_end_date"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree
  add_index "users", ["rut"], name: "index_users_on_rut", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "weekly_business_sales", force: :cascade do |t|
    t.integer  "store_id",                              null: false
    t.integer  "hardware_sales",  limit: 8, default: 0, null: false
    t.integer  "accessory_sales", limit: 8, default: 0, null: false
    t.integer  "game_sales",      limit: 8, default: 0, null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.date     "week_start"
    t.date     "month"
    t.integer  "week_number",                           null: false
    t.datetime "deleted_at"
  end

  add_index "weekly_business_sales", ["deleted_at"], name: "index_weekly_business_sales_on_deleted_at", using: :btree
  add_index "weekly_business_sales", ["store_id"], name: "index_weekly_business_sales_on_store_id", using: :btree

  create_table "zones", force: :cascade do |t|
    t.text     "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  add_index "zones", ["deleted_at"], name: "index_zones_on_deleted_at", using: :btree
  add_index "zones", ["name"], name: "index_zones_on_name", unique: true, using: :btree

  add_foreign_key "broadcasts", "message_actions"
  add_foreign_key "categories", "organizations"
  add_foreign_key "checkins", "stores"
  add_foreign_key "checkins", "users"
  add_foreign_key "checklist_item_values", "data_parts"
  add_foreign_key "checklist_item_values", "reports"
  add_foreign_key "daily_head_counts", "brands"
  add_foreign_key "daily_head_counts", "reports"
  add_foreign_key "daily_product_sales", "products"
  add_foreign_key "daily_product_sales", "reports"
  add_foreign_key "daily_sales", "brands"
  add_foreign_key "daily_sales", "reports"
  add_foreign_key "daily_stocks", "brands"
  add_foreign_key "daily_stocks", "reports"
  add_foreign_key "data_parts", "organizations"
  add_foreign_key "data_parts", "subsections"
  add_foreign_key "devices", "users"
  add_foreign_key "images", "categories"
  add_foreign_key "images", "data_parts"
  add_foreign_key "images", "reports"
  add_foreign_key "images", "users"
  add_foreign_key "invitations", "roles"
  add_foreign_key "message_actions", "organizations"
  add_foreign_key "messages", "broadcasts", on_delete: :cascade
  add_foreign_key "messages", "users"
  add_foreign_key "platforms", "brands"
  add_foreign_key "products", "platforms"
  add_foreign_key "products", "product_classifications"
  add_foreign_key "products", "product_types"
  add_foreign_key "promotion_states", "promotions"
  add_foreign_key "promotion_states", "reports"
  add_foreign_key "promotion_states", "stores"
  add_foreign_key "promotions", "data_parts", column: "checklist_id"
  add_foreign_key "report_types", "organizations"
  add_foreign_key "reports", "report_types"
  add_foreign_key "reports", "stores"
  add_foreign_key "roles", "organizations"
  add_foreign_key "sale_goal_uploads", "users"
  add_foreign_key "sale_goals", "sale_goal_uploads"
  add_foreign_key "sale_goals", "stores"
  add_foreign_key "sections", "organizations"
  add_foreign_key "sections", "section_types"
  add_foreign_key "stock_break_events", "products"
  add_foreign_key "stock_break_events", "reports"
  add_foreign_key "stock_breaks", "dealers"
  add_foreign_key "stock_breaks", "product_classifications"
  add_foreign_key "stock_breaks", "store_types"
  add_foreign_key "stores", "dealers"
  add_foreign_key "stores", "store_types"
  add_foreign_key "stores", "zones"
  add_foreign_key "subsection_items", "subsection_item_types"
  add_foreign_key "subsections", "sections"
  add_foreign_key "users", "roles"
  add_foreign_key "weekly_business_sales", "stores"
end
