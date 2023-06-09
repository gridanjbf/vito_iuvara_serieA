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

ActiveRecord::Schema[7.0].define(version: 2023_04_13_191034) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "matches", force: :cascade do |t|
    t.bigint "away_id", null: false
    t.bigint "home_id", null: false
    t.integer "home_score"
    t.integer "away_score"
    t.bigint "winner_id"
    t.integer "round"
    t.string "season"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["away_id"], name: "index_matches_on_away_id"
    t.index ["home_id"], name: "index_matches_on_home_id"
    t.index ["winner_id"], name: "index_matches_on_winner_id"
  end

  create_table "score_swaps", force: :cascade do |t|
    t.integer "winner_score"
    t.integer "loser_score"
    t.bigint "match_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_score_swaps_on_match_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.integer "score", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
