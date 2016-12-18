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

ActiveRecord::Schema.define(version: 20161216005052) do

  create_table "commodities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "commodities", ["name"], name: "index_commodities_on_name", using: :btree

  create_table "commodity_errors", force: :cascade do |t|
    t.integer  "commodity_id", limit: 4
    t.string   "message",      limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "commodity_errors", ["commodity_id"], name: "index_commodity_errors_on_commodity_id", using: :btree

  create_table "commodity_histories", force: :cascade do |t|
    t.integer  "commodity_id",     limit: 4
    t.float    "last_trade_price", limit: 24
    t.date     "last_trade_date"
    t.float    "change",           limit: 24
    t.float    "previous_close",   limit: 24
    t.integer  "update_type",      limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "commodity_histories", ["commodity_id"], name: "index_commodity_histories_on_commodity_id", using: :btree
  add_index "commodity_histories", ["update_type"], name: "index_commodity_histories_on_update_type", using: :btree

end
