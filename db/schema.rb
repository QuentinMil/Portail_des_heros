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

ActiveRecord::Schema[7.1].define(version: 2024_07_16_100158) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.bigint "universe_id", null: false
    t.string "strength"
    t.string "dexterity"
    t.string "intelligence"
    t.string "constitution"
    t.string "wisdom"
    t.string "charisma"
    t.string "available_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["universe_id"], name: "index_characters_on_universe_id"
    t.index ["user_id"], name: "index_characters_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.bigint "party_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["party_id"], name: "index_messages_on_party_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.text "user_notes"
    t.text "other_notes"
    t.bigint "character_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_notes_on_character_id"
  end

  create_table "parties", force: :cascade do |t|
    t.string "name"
    t.bigint "universe_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["universe_id"], name: "index_parties_on_universe_id"
    t.index ["user_id"], name: "index_parties_on_user_id"
  end

  create_table "party_characters", force: :cascade do |t|
    t.bigint "character_id", null: false
    t.bigint "party_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_party_characters_on_character_id"
    t.index ["party_id"], name: "index_party_characters_on_party_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "category"
    t.boolean "tutorial"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "universes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "pseudo"
    t.string "player_level"
    t.boolean "game_master"
    t.boolean "admin"
    t.integer "completion_rate_basics", default: 0
    t.integer "completion_rate_universes", default: 0
    t.integer "completion_rate_characters", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "characters", "universes"
  add_foreign_key "characters", "users"
  add_foreign_key "messages", "parties"
  add_foreign_key "messages", "users"
  add_foreign_key "notes", "characters"
  add_foreign_key "parties", "universes"
  add_foreign_key "parties", "users"
  add_foreign_key "party_characters", "characters"
  add_foreign_key "party_characters", "parties"
  add_foreign_key "posts", "users"
end
