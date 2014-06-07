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

ActiveRecord::Schema.define(version: 9) do

  create_table "nodes", force: true do |t|
    t.string   "name",       null: false
    t.string   "intro"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topic_replies", force: true do |t|
    t.text     "content",    null: false
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topic_replies", ["topic_id"], name: "index_topic_replies_on_topic_id", using: :btree
  add_index "topic_replies", ["user_id"], name: "index_topic_replies_on_user_id", using: :btree

  create_table "topics", force: true do |t|
    t.string   "name",                       null: false
    t.text     "content",                    null: false
    t.boolean  "recommend",  default: false
    t.integer  "user_id"
    t.integer  "node_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tag"
  end

  add_index "topics", ["node_id"], name: "index_topics_on_node_id", using: :btree
  add_index "topics", ["tag"], name: "index_topics_on_tag", using: :btree
  add_index "topics", ["user_id"], name: "index_topics_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,        null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "utype",                  default: "normal"
    t.integer  "point",                  default: 50
    t.string   "avatar"
    t.integer  "stb",                    default: 0
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree
  add_index "users", ["utype"], name: "index_users_on_utype", using: :btree

end
