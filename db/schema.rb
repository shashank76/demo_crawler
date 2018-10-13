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

ActiveRecord::Schema.define(version: 2018_10_13_175621) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deleted_news", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "news_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["news_id"], name: "index_deleted_news_on_news_id"
    t.index ["user_id"], name: "index_deleted_news_on_user_id"
  end

  create_table "news", force: :cascade do |t|
    t.string "url"
    t.string "title"
    t.string "hacker_url"
    t.string "posted_on"
    t.string "upvotes"
    t.string "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_news", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "news_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["news_id"], name: "index_user_news_on_news_id"
    t.index ["user_id"], name: "index_user_news_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "deleted_news", "news"
  add_foreign_key "deleted_news", "users"
  add_foreign_key "user_news", "news"
  add_foreign_key "user_news", "users"
end
