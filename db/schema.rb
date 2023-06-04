# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_26_064837) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.integer "user_id"
    t.integer "tweet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string "image"
    t.string "imgeable_type"
    t.bigint "imgeable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imgeable_type", "imgeable_id"], name: "index_images_on_imgeable"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "tweet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "recipient_id"
    t.integer "actor_id"
    t.string "notifiable_type"
    t.integer "notifiable_id"
    t.string "action"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "points", force: :cascade do |t|
    t.integer "point"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "caption"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "retweeted_project_id"
    t.index ["retweeted_project_id"], name: "index_projects_on_retweeted_project_id"
  end

  create_table "tweets", force: :cascade do |t|
    t.text "caption"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "original_tweet_id"
    t.index ["original_tweet_id"], name: "index_tweets_on_original_tweet_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "projects", "projects", column: "retweeted_project_id"
  add_foreign_key "tweets", "tweets", column: "original_tweet_id"
end
