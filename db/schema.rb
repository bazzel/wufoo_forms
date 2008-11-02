# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081027191854) do

  create_table "foos", :force => true do |t|
    t.string   "field_0"
    t.string   "field_1"
    t.string   "field_2"
    t.string   "field_3"
    t.string   "field_4"
    t.string   "field_5"
    t.string   "field_6"
    t.string   "field_7"
    t.string   "field_8"
    t.string   "field_9"
    t.string   "field_10"
    t.string   "field_11"
    t.string   "field_12"
    t.string   "field_13"
    t.string   "field_14"
    t.string   "field_15"
    t.string   "field_16"
    t.string   "field_17"
    t.string   "field_18"
    t.string   "field_19"
    t.string   "field_20"
    t.string   "field_21"
    t.string   "field_22"
    t.string   "field_23"
    t.string   "field_24"
    t.string   "field_25"
    t.string   "field_26"
    t.string   "field_27"
    t.string   "field_28"
    t.string   "field_29"
    t.string   "req_field_0"
    t.string   "req_field_1"
    t.string   "req_field_2"
    t.string   "req_field_3"
    t.string   "req_field_4"
    t.string   "req_field_5"
    t.string   "req_field_6"
    t.string   "req_field_7"
    t.string   "req_field_8"
    t.string   "req_field_9"
    t.string   "req_field_10"
    t.string   "req_field_11"
    t.string   "req_field_12"
    t.string   "req_field_13"
    t.string   "req_field_14"
    t.string   "req_field_15"
    t.string   "req_field_16"
    t.string   "req_field_17"
    t.string   "req_field_18"
    t.string   "req_field_19"
    t.string   "req_field_20"
    t.string   "req_field_21"
    t.string   "req_field_22"
    t.string   "req_field_23"
    t.string   "req_field_24"
    t.string   "req_field_25"
    t.string   "req_field_26"
    t.string   "req_field_27"
    t.string   "req_field_28"
    t.string   "req_field_29"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wufoo_themes", :force => true do |t|
    t.string   "theme"
    t.string   "css"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
