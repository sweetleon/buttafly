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

ActiveRecord::Schema.define(version: 20140919055223) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buttafly_legends", force: true do |t|
    t.integer  "cartographer_id"
    t.json     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "buttafly_mappings", force: true do |t|
    t.integer  "legend_id"
    t.integer  "originable_id"
    t.string   "originable_type"
    t.integer  "targetable_id"
    t.string   "targetable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "buttafly_mappings", ["legend_id"], name: "index_buttafly_mappings_on_legend_id", using: :btree
  add_index "buttafly_mappings", ["originable_id", "originable_type"], name: "index_buttafly_mappings_on_originable_id_and_originable_type", using: :btree
  add_index "buttafly_mappings", ["targetable_id", "targetable_type"], name: "index_buttafly_mappings_on_targetable_id_and_targetable_type", using: :btree

  create_table "buttafly_spreadsheets", force: true do |t|
    t.json     "data"
    t.string   "name"
    t.integer  "user_id"
    t.datetime "imported_at"
    t.datetime "processed_at"
    t.string   "aasm_state"
    t.integer  "source_row_count"
    t.integer  "mtime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "flat_file"
  end

  add_index "buttafly_spreadsheets", ["aasm_state"], name: "index_buttafly_spreadsheets_on_aasm_state", using: :btree
  add_index "buttafly_spreadsheets", ["imported_at"], name: "index_buttafly_spreadsheets_on_imported_at", using: :btree
  add_index "buttafly_spreadsheets", ["name"], name: "index_buttafly_spreadsheets_on_name", unique: true, using: :btree
  add_index "buttafly_spreadsheets", ["processed_at"], name: "index_buttafly_spreadsheets_on_processed_at", using: :btree
  add_index "buttafly_spreadsheets", ["user_id"], name: "index_buttafly_spreadsheets_on_user_id", using: :btree

  create_table "dummy_children", force: true do |t|
    t.string   "child_name"
    t.integer  "dummy_parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dummy_parents", force: true do |t|
    t.string   "father_name"
    t.string   "mother_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
