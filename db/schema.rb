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

ActiveRecord::Schema.define(version: 20180316161148) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", primary_key: "contact_id", id: :serial, force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "phone_number"
    t.string "address"
    t.string "city"
    t.string "street"
    t.string "region"
    t.string "country"
    t.string "postal_code"
    t.integer "users_id"
    t.index ["users_id"], name: "index_contacts_on_users_id"
  end

  create_table "users", primary_key: "users_id", id: :serial, force: :cascade do |t|
    t.string "user_type"
    t.string "username"
    t.string "password"
    t.string "user"
    t.string "provider"
    t.string "uid"
    t.string "name"
    t.string "oauth_token"
    t.string "refresh_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
