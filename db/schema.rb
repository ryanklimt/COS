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

ActiveRecord::Schema.define(version: 20131030135024) do

  create_table "contests", force: true do |t|
    t.datetime "deadline"
    t.datetime "start"
    t.text     "description"
    t.string   "name"
    t.string   "contest_type"
    t.integer  "user_id"
    t.integer  "referee_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", force: true do |t|
    t.string   "status"
    t.date     "completion"
    t.datetime "earliest_start"
    t.integer  "manager_id"
    t.string   "manager_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "matches", ["manager_id", "manager_type"], name: "index_matches_on_manager_id_and_manager_type"

  create_table "player_matches", force: true do |t|
    t.float    "score"
    t.string   "result"
    t.integer  "player_id"
    t.integer  "match_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "player_matches", ["match_id"], name: "index_player_matches_on_match_id"
  add_index "player_matches", ["player_id"], name: "index_player_matches_on_player_id"

  create_table "players", force: true do |t|
    t.string   "file_location"
    t.text     "description"
    t.string   "name"
    t.boolean  "downloadable",  default: false
    t.boolean  "playable",      default: true
    t.integer  "user_id"
    t.integer  "contest_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["contest_id"], name: "index_players_on_contest_id"
  add_index "players", ["user_id"], name: "index_players_on_user_id"

  create_table "referees", force: true do |t|
    t.string   "file_location"
    t.string   "name"
    t.string   "rules_url"
    t.integer  "players_per_game"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "referees", ["user_id"], name: "index_referees_on_user_id"

  create_table "users", force: true do |t|
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "email"
    t.boolean  "admin",           default: false
    t.boolean  "contest_creator", default: false
    t.boolean  "banned",          default: false
    t.string   "chat_url"
  end

end
