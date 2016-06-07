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

ActiveRecord::Schema.define(version: 20160607193744) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "ar_internal_metadata", primary_key: "key", force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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
  end

  add_index "checkins", ["arrival_lonlat"], name: "index_checkins_on_arrival_lonlat", using: :gist
  add_index "checkins", ["exit_lonlat"], name: "index_checkins_on_exit_lonlat", using: :gist
  add_index "checkins", ["user_id"], name: "index_checkins_on_user_id", using: :btree

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
    t.integer  "user_id",       null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "category_id"
    t.integer  "report_id"
    t.integer  "detail_id"
    t.integer  "resource_id"
    t.text     "resource_type"
  end

  add_index "images", ["category_id"], name: "index_images_on_category_id", using: :btree
  add_index "images", ["data_part_id"], name: "index_images_on_data_part_id", using: :btree
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

  create_table "platforms", force: :cascade do |t|
    t.text     "name",            null: false
    t.integer  "organization_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "platforms", ["organization_id", "name"], name: "index_platforms_on_organization_id_and_name", unique: true, using: :btree
  add_index "platforms", ["organization_id"], name: "index_platforms_on_organization_id", using: :btree

  create_table "platforms_top_list_items", id: false, force: :cascade do |t|
    t.integer "platform_id"
    t.integer "top_list_item_id"
  end

  add_index "platforms_top_list_items", ["platform_id"], name: "index_platforms_top_list_items_on_platform_id", using: :btree
  add_index "platforms_top_list_items", ["top_list_item_id"], name: "index_platforms_top_list_items_on_top_list_item_id", using: :btree

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

  create_table "report_colunms", force: :cascade do |t|
    t.integer  "organization_id"
    t.text     "field_name"
    t.text     "column_name"
    t.integer  "column_type"
    t.integer  "position"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "report_colunms", ["organization_id"], name: "index_report_colunms_on_organization_id", using: :btree

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
    t.integer  "organization_id",                    null: false
    t.integer  "report_type_id",                     null: false
    t.json     "dynamic_attributes", default: {},    null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "creator_id",                         null: false
    t.datetime "limit_date"
    t.boolean  "finished",           default: false, null: false
    t.integer  "assigned_user_id"
    t.text     "pdf"
    t.boolean  "pdf_uploaded",       default: false, null: false
    t.text     "uuid"
  end

  add_index "reports", ["assigned_user_id"], name: "index_reports_on_assigned_user_id", using: :btree
  add_index "reports", ["creator_id"], name: "index_reports_on_creator_id", using: :btree
  add_index "reports", ["organization_id"], name: "index_reports_on_organization_id", using: :btree
  add_index "reports", ["report_type_id"], name: "index_reports_on_report_type_id", using: :btree
  add_index "reports", ["uuid"], name: "index_reports_on_uuid", using: :btree

  create_table "roles", force: :cascade do |t|
    t.integer  "organization_id", null: false
    t.text     "name",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["organization_id", "name"], name: "index_roles_on_organization_id_and_name", unique: true, using: :btree
  add_index "roles", ["organization_id"], name: "index_roles_on_organization_id", using: :btree

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
  end

  add_index "stores", ["dealer_id"], name: "index_stores_on_dealer_id", using: :btree
  add_index "stores", ["deleted_at"], name: "index_stores_on_deleted_at", using: :btree
  add_index "stores", ["zone_id"], name: "index_stores_on_zone_id", using: :btree

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

  create_table "top_list_items", force: :cascade do |t|
    t.integer  "top_list_id"
    t.text     "name",                     null: false
    t.text     "images",      default: [], null: false, array: true
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "top_list_items", ["top_list_id", "name"], name: "index_top_list_items_on_top_list_id_and_name", unique: true, using: :btree
  add_index "top_list_items", ["top_list_id"], name: "index_top_list_items_on_top_list_id", using: :btree

  create_table "top_lists", force: :cascade do |t|
    t.integer  "organization_id", null: false
    t.text     "name"
    t.text     "icon"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "top_lists", ["organization_id"], name: "index_top_lists_on_organization_id", using: :btree

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
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree
  add_index "users", ["rut"], name: "index_users_on_rut", unique: true, using: :btree

  create_table "zones", force: :cascade do |t|
    t.text     "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  add_index "zones", ["deleted_at"], name: "index_zones_on_deleted_at", using: :btree
  add_index "zones", ["name"], name: "index_zones_on_name", unique: true, using: :btree

  add_foreign_key "categories", "organizations"
  add_foreign_key "checkins", "users"
  add_foreign_key "data_parts", "organizations"
  add_foreign_key "data_parts", "subsections"
  add_foreign_key "devices", "users"
  add_foreign_key "images", "categories"
  add_foreign_key "images", "data_parts"
  add_foreign_key "images", "reports"
  add_foreign_key "images", "users"
  add_foreign_key "invitations", "roles"
  add_foreign_key "platforms", "organizations"
  add_foreign_key "promotions", "data_parts", column: "checklist_id"
  add_foreign_key "report_colunms", "organizations"
  add_foreign_key "report_types", "organizations"
  add_foreign_key "reports", "organizations"
  add_foreign_key "reports", "report_types"
  add_foreign_key "roles", "organizations"
  add_foreign_key "sections", "organizations"
  add_foreign_key "sections", "section_types"
  add_foreign_key "stores", "dealers"
  add_foreign_key "stores", "zones"
  add_foreign_key "subsection_items", "subsection_item_types"
  add_foreign_key "subsections", "sections"
  add_foreign_key "top_list_items", "top_lists"
  add_foreign_key "top_lists", "organizations"
  add_foreign_key "users", "roles"
end
