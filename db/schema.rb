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

ActiveRecord::Schema.define(version: 20170221103942) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "address"
    t.integer  "user_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "address_id"
    t.string   "usage"
    t.integer  "twd_amount",         default: 0
    t.float    "btc_amount",         default: 0.0
    t.datetime "btc_amount_expired"
    t.float    "btc_recieved",       default: 0.0
    t.string   "status",             default: "waiting"
    t.boolean  "notice",             default: false
    t.integer  "to_id"
    t.string   "to_email"
    t.float    "btc_pending",        default: 0.0
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

  create_table "days", force: :cascade do |t|
    t.integer  "user_id"
    t.float    "balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "date"
  end

  add_index "days", ["user_id"], name: "index_days_on_user_id", using: :btree

  create_table "median_functions", force: :cascade do |t|
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "twd_amount"
    t.float    "btc_amount"
    t.datetime "btc_amount_expired"
    t.float    "btc_recieved",       default: 0.0
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "address_id"
    t.string   "status",             default: "waiting"
    t.boolean  "notice",             default: false
  end

  add_index "transactions", ["address_id"], name: "index_transactions_on_address_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                            default: "",    null: false
    t.string   "encrypted_password",               default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.integer  "level",                            default: 0
    t.float    "balance",                          default: 0.0
    t.text     "line_id"
    t.text     "username"
    t.integer  "tutor_id",               limit: 2
    t.float    "lv1_pool",                         default: 0.0
    t.float    "lv2_pool",                         default: 0.0
    t.float    "lv3_pool",                         default: 0.0
    t.float    "lv4_pool",                         default: 0.0
    t.float    "lv5_pool",                         default: 0.0
    t.float    "lv6_pool",                         default: 0.0
    t.float    "lv7_pool",                         default: 0.0
    t.boolean  "upgrading",                        default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "addresses", "users"
  add_foreign_key "days", "users"
  add_foreign_key "transactions", "addresses"
end
