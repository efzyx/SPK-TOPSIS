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

ActiveRecord::Schema.define(version: 20170314081306) do

  create_table "alternatifs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "nama_alternatif"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "kriteria", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "nama"
    t.integer  "tipe"
    t.float    "bobot",      limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "rangkings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "alternatif_id"
    t.integer  "kriteria_id"
    t.float    "nilai",         limit: 24
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["alternatif_id"], name: "index_rangkings_on_alternatif_id", using: :btree
    t.index ["kriteria_id"], name: "index_rangkings_on_kriteria_id", using: :btree
  end

  add_foreign_key "rangkings", "alternatifs"
  add_foreign_key "rangkings", "kriteria", column: "kriteria_id"
end
