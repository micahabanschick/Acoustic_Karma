# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 8) do

  create_table "albums", force: :cascade do |t|
    t.string "name"
    t.string "release_date"
    t.integer "user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "reply"
    t.integer "user_id"
    t.integer "post_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "content"
    t.integer "user_id"
    t.datetime "date_posted"
  end

  create_table "song_genres", force: :cascade do |t|
    t.integer "song_id"
    t.integer "genre_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string "name"
    t.string "release_date"
    t.integer "user_id"
    t.integer "album_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "password_digest"
  end

end
