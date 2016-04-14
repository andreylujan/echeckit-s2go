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

ActiveRecord::Schema.define(version: 20160414211348) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "categories_pictures", id: false, force: :cascade do |t|
    t.integer "category_id"
    t.integer "picture_id"
  end

  add_index "categories_pictures", ["category_id"], name: "index_categories_pictures_on_category_id", using: :btree
  add_index "categories_pictures", ["picture_id"], name: "index_categories_pictures_on_picture_id", using: :btree

  create_table "data_parts", force: :cascade do |t|
    t.integer  "subsection_id"
    t.text     "type",                         null: false
    t.text     "name",                         null: false
    t.text     "icon"
    t.boolean  "required",      default: true, null: false
    t.integer  "data_part_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "data_parts", ["data_part_id"], name: "index_data_parts_on_data_part_id", using: :btree
  add_index "data_parts", ["subsection_id"], name: "index_data_parts_on_subsection_id", using: :btree

  create_table "dealers", force: :cascade do |t|
    t.text     "name",         null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "contact"
    t.text     "phone_number"
    t.text     "address"
  end

  add_index "dealers", ["name"], name: "index_dealers_on_name", unique: true, using: :btree

  create_table "dealers_zones", id: false, force: :cascade do |t|
    t.integer "dealer_id"
    t.integer "zone_id"
  end

  add_index "dealers_zones", ["dealer_id", "zone_id"], name: "index_dealers_zones_on_dealer_id_and_zone_id", unique: true, using: :btree

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

  create_table "pictures", force: :cascade do |t|
    t.text     "url"
    t.integer  "data_part_id"
    t.integer  "user_id",      null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "pictures", ["data_part_id"], name: "index_pictures_on_data_part_id", using: :btree
  add_index "pictures", ["user_id"], name: "index_pictures_on_user_id", using: :btree

  create_table "regions", force: :cascade do |t|
    t.text     "name",       null: false
    t.integer  "ordinal",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "regions", ["name"], name: "index_regions_on_name", unique: true, using: :btree
  add_index "regions", ["ordinal"], name: "index_regions_on_ordinal", unique: true, using: :btree

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
    t.text     "title"
    t.integer  "organization_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "section_type_id", null: false
  end

  add_index "sections", ["organization_id"], name: "index_sections_on_organization_id", using: :btree
  add_index "sections", ["section_type_id"], name: "index_sections_on_section_type_id", using: :btree

  create_table "stores", force: :cascade do |t|
    t.text     "name",         null: false
    t.integer  "dealer_id",    null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "zone_id",      null: false
    t.text     "contact"
    t.text     "phone_number"
    t.text     "address"
  end

  add_index "stores", ["dealer_id", "name"], name: "index_stores_on_dealer_id_and_name", unique: true, using: :btree
  add_index "stores", ["dealer_id"], name: "index_stores_on_dealer_id", using: :btree
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
    t.text     "name",                          null: false
    t.text     "icon"
    t.boolean  "has_pictures",   default: true, null: false
    t.boolean  "has_comment",    default: true, null: false
    t.integer  "max_pictures",   default: 20,   null: false
    t.integer  "comment_length", default: 256,  null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
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
    t.text     "picture"
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
    t.integer  "region_id",  null: false
  end

  add_index "zones", ["name"], name: "index_zones_on_name", unique: true, using: :btree
  add_index "zones", ["region_id"], name: "index_zones_on_region_id", using: :btree

  add_foreign_key "categories", "organizations"
  add_foreign_key "data_parts", "data_parts"
  add_foreign_key "data_parts", "subsections"
  add_foreign_key "invitations", "roles"
  add_foreign_key "pictures", "data_parts"
  add_foreign_key "pictures", "users"
  add_foreign_key "roles", "organizations"
  add_foreign_key "sections", "organizations"
  add_foreign_key "sections", "section_types"
  add_foreign_key "stores", "dealers"
  add_foreign_key "stores", "zones"
  add_foreign_key "subsection_items", "subsection_item_types"
  add_foreign_key "subsections", "sections"
  add_foreign_key "users", "roles"
  add_foreign_key "zones", "regions"
end
