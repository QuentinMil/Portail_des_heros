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

ActiveRecord::Schema[7.1].define(version: 2024_07_19_005255) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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
    t.bigint "race_id"
    t.bigint "univers_class_id"
    t.integer "completion_rate"
    t.text "backstory"
    t.index ["race_id"], name: "index_characters_on_race_id"
    t.index ["univers_class_id"], name: "index_characters_on_univers_class_id"
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "races", force: :cascade do |t|
    t.string "name"
    t.bigint "universe_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["universe_id"], name: "index_races_on_universe_id"
  end

  create_table "tutorials", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "video_url"
    t.bigint "universe_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tuto_order"
    t.index ["universe_id"], name: "index_tutorials_on_universe_id"
    t.index ["user_id"], name: "index_tutorials_on_user_id"
  end

  create_table "univers_classes", force: :cascade do |t|
    t.string "name"
    t.bigint "universe_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["universe_id"], name: "index_univers_classes_on_universe_id"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "characters", "races"
  add_foreign_key "characters", "univers_classes"
  add_foreign_key "characters", "universes"
  add_foreign_key "characters", "users"
  add_foreign_key "messages", "parties"
  add_foreign_key "messages", "users"
  add_foreign_key "notes", "characters"
  add_foreign_key "parties", "universes"
  add_foreign_key "parties", "users"
  add_foreign_key "party_characters", "characters"
  add_foreign_key "party_characters", "parties"
  add_foreign_key "races", "universes"
  add_foreign_key "tutorials", "universes"
  add_foreign_key "tutorials", "users"
  add_foreign_key "univers_classes", "universes"
end
