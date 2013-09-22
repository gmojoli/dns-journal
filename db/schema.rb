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

ActiveRecord::Schema.define(version: 20130915100656) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dns_zones", force: true do |t|
    t.string   "admin_email"
    t.integer  "version"
    t.string   "origin"
    t.integer  "ttl"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "soa_section_id"
    t.integer  "domain_id"
    t.integer  "user_id"
  end

  add_index "dns_zones", ["user_id"], name: "index_dns_zones_on_user_id", using: :btree

  create_table "domains", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "current_dns_zone"
    t.integer  "user_id"
    t.text     "note"
    t.string   "slug"
  end

  add_index "domains", ["user_id"], name: "index_domains_on_user_id", using: :btree

  create_table "domains_dns_zones", force: true do |t|
    t.integer "domain_id"
    t.integer "dns_zone_id"
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

  create_table "resource_records", force: true do |t|
    t.string   "value"
    t.string   "rfc"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dns_zone_id"
    t.string   "resource_type"
    t.string   "name"
    t.string   "option"
    t.integer  "user_id"
  end

  add_index "resource_records", ["user_id"], name: "index_resource_records_on_user_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "soa_sections", force: true do |t|
    t.string   "primary_domain_name"
    t.string   "zone_class"
    t.string   "mname"
    t.string   "rname"
    t.integer  "serial_number"
    t.integer  "refresh"
    t.integer  "retry"
    t.integer  "expire"
    t.integer  "minimum"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dns_zone_id"
    t.integer  "revision"
    t.integer  "user_id"
  end

  add_index "soa_sections", ["user_id"], name: "index_soa_sections_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "surname"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
