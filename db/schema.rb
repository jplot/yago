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

ActiveRecord::Schema[7.0].define(version: 2023_02_25_210236) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id"], name: "index_activities_on_record"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.string "address", null: false
    t.string "additional_info", default: "", null: false
    t.string "zipcode", default: "", null: false
    t.string "city", null: false
    t.string "country", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id"], name: "index_addresses_on_record"
  end

  create_table "companies", force: :cascade do |t|
    t.string "kind", null: false
    t.string "name", null: false
    t.string "number", null: false
    t.boolean "natural_person", null: false
    t.integer "annual_revenue", default: 0, null: false
    t.date "activity_begins_at", null: false
    t.date "activity_ends_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "establishments", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.boolean "primary", default: false, null: false
    t.string "name"
    t.string "number", null: false
    t.date "activity_begins_at", null: false
    t.date "activity_ends_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_establishments_on_company_id"
  end

  create_table "managers", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "company_id", null: false
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_managers_on_company_id"
    t.index ["person_id"], name: "index_managers_on_person_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "usage_name", default: "", null: false
    t.string "first_name", null: false
    t.string "middle_name", default: "", null: false
    t.string "last_name", null: false
    t.string "email", default: "", null: false
    t.string "phone", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "establishments", "companies"
  add_foreign_key "managers", "companies"
  add_foreign_key "managers", "people"
end
