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

ActiveRecord::Schema.define(version: 2019_11_09_084600) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "city"
  end

  create_table "technicians", force: :cascade do |t|
    t.string "name"
  end

  create_table "work_orders", force: :cascade do |t|
    t.bigint "technician_id"
    t.bigint "location_id"
    t.datetime "time"
    t.integer "duration"
    t.integer "price"
    t.index ["location_id"], name: "index_work_orders_on_location_id"
    t.index ["technician_id"], name: "index_work_orders_on_technician_id"
  end

  add_foreign_key "work_orders", "locations"
  add_foreign_key "work_orders", "technicians"
end
