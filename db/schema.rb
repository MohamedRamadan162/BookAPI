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

ActiveRecord::Schema[7.0].define(version: 2024_08_26_193928) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.date "published_date"
    t.index ["author_id"], name: "index_books_on_author_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name_en", null: false
    t.string "name_ar", null: false
    t.string "dial_code", null: false
    t.string "short_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devices_tokens", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_devices_tokens_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "image"
    t.integer "gender"
    t.datetime "date_of_birth"
    t.string "locale", default: "en"
    t.integer "status"
    t.bigint "country_id"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "forgot_password_digest"
    t.datetime "forgot_password_digest_created_at"
    t.boolean "is_forgot_password_code_used", default: false
    t.boolean "admin?"
    t.index ["country_id"], name: "index_users_on_country_id"
  end

  add_foreign_key "books", "authors"
  add_foreign_key "devices_tokens", "users"
  add_foreign_key "users", "countries"
end
