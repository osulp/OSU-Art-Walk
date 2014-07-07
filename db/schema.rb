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

ActiveRecord::Schema.define(version: 20140707223635) do

  create_table "art_piece_buildings", force: true do |t|
    t.integer "floor"
    t.string  "location"
    t.integer "art_piece_id"
    t.integer "building_id"
  end

  add_index "art_piece_buildings", ["art_piece_id"], name: "index_art_piece_buildings_on_art_piece_id"
  add_index "art_piece_buildings", ["building_id"], name: "index_art_piece_buildings_on_building_id"

  create_table "art_pieces", force: true do |t|
    t.string   "title"
    t.string   "medium"
    t.string   "creation_date"
    t.string   "size"
    t.text     "legal_info"
    t.boolean  "is_temporary"
    t.datetime "temporary_until"
    t.boolean  "private"
    t.string   "contact_info"
    t.text     "description"
    t.boolean  "on_campus"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bookmarks", force: true do |t|
    t.integer  "user_id",       null: false
    t.string   "user_type"
    t.string   "document_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "document_type"
  end

  add_index "bookmarks", ["user_id"], name: "index_bookmarks_on_user_id"

  create_table "buildings", force: true do |t|
    t.string "name"
    t.text   "description"
    t.float  "lat"
    t.float  "long"
  end

  create_table "searches", force: true do |t|
    t.text     "query_params"
    t.integer  "user_id"
    t.string   "user_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "searches", ["user_id"], name: "index_searches_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
