# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150819204901) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "basin_designs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ceiling_lights_designs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "colors", force: :cascade do |t|
    t.string  "name"
    t.integer "material_id"
  end

  add_index "colors", ["material_id"], name: "index_colors_on_material_id", using: :btree

  create_table "console_counter_vanity_designs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "door_trim_designs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres_products", force: :cascade do |t|
    t.integer "genre_id"
    t.integer "product_id"
  end

  add_index "genres_products", ["genre_id"], name: "index_genres_products_on_genre_id", using: :btree
  add_index "genres_products", ["product_id"], name: "index_genres_products_on_product_id", using: :btree

  create_table "lever_designs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "materials", force: :cascade do |t|
    t.string "name"
  end

  create_table "overall_colors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_sub_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "product_type_id"
  end

  add_index "product_sub_types", ["product_type_id"], name: "index_product_sub_types_on_product_type_id", using: :btree

  create_table "product_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.string   "number"
    t.text     "long_description"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "product_type_id"
    t.integer  "product_sub_type_id"
    t.integer  "genre_id"
    t.integer  "style_id"
  end

  add_index "products", ["genre_id"], name: "index_products_on_genre_id", using: :btree
  add_index "products", ["product_sub_type_id"], name: "index_products_on_product_sub_type_id", using: :btree
  add_index "products", ["product_type_id"], name: "index_products_on_product_type_id", using: :btree
  add_index "products", ["style_id"], name: "index_products_on_style_id", using: :btree

  create_table "products_styles", force: :cascade do |t|
    t.integer "product_id"
    t.integer "style_id"
  end

  add_index "products_styles", ["product_id"], name: "index_products_styles_on_product_id", using: :btree
  add_index "products_styles", ["style_id"], name: "index_products_styles_on_style_id", using: :btree

  create_table "skus", force: :cascade do |t|
    t.string  "name"
    t.integer "product_id"
    t.integer "material_id"
    t.integer "color_id"
    t.integer "genre_id"
    t.integer "style_id"
    t.integer "product_type_id"
    t.integer "product_sub_type_id"
    t.integer "basin_design_id"
    t.integer "ceiling_lights_design_id"
    t.integer "console_counter_vanity_design_id"
    t.integer "door_trim_design_id"
    t.integer "lever_design_id"
    t.integer "overall_color_id"
    t.integer "wall_lights_design_id"
    t.integer "wall_paper_design_id"
    t.integer "wall_trim_design_id"
    t.integer "water_closet_handle_design_id"
    t.string  "number"
  end

  add_index "skus", ["basin_design_id"], name: "index_skus_on_basin_design_id", using: :btree
  add_index "skus", ["ceiling_lights_design_id"], name: "index_skus_on_ceiling_lights_design_id", using: :btree
  add_index "skus", ["color_id"], name: "index_skus_on_color_id", using: :btree
  add_index "skus", ["console_counter_vanity_design_id"], name: "index_skus_on_console_counter_vanity_design_id", using: :btree
  add_index "skus", ["door_trim_design_id"], name: "index_skus_on_door_trim_design_id", using: :btree
  add_index "skus", ["genre_id"], name: "index_skus_on_genre_id", using: :btree
  add_index "skus", ["lever_design_id"], name: "index_skus_on_lever_design_id", using: :btree
  add_index "skus", ["material_id"], name: "index_skus_on_material_id", using: :btree
  add_index "skus", ["overall_color_id"], name: "index_skus_on_overall_color_id", using: :btree
  add_index "skus", ["product_id"], name: "index_skus_on_product_id", using: :btree
  add_index "skus", ["product_sub_type_id"], name: "index_skus_on_product_sub_type_id", using: :btree
  add_index "skus", ["product_type_id"], name: "index_skus_on_product_type_id", using: :btree
  add_index "skus", ["style_id"], name: "index_skus_on_style_id", using: :btree
  add_index "skus", ["wall_lights_design_id"], name: "index_skus_on_wall_lights_design_id", using: :btree
  add_index "skus", ["wall_paper_design_id"], name: "index_skus_on_wall_paper_design_id", using: :btree
  add_index "skus", ["wall_trim_design_id"], name: "index_skus_on_wall_trim_design_id", using: :btree
  add_index "skus", ["water_closet_handle_design_id"], name: "index_skus_on_water_closet_handle_design_id", using: :btree

  create_table "styles", force: :cascade do |t|
    t.string   "name"
    t.integer  "genre_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "is_collection"
  end

  add_index "styles", ["genre_id"], name: "index_styles_on_genre_id", using: :btree

  create_table "wall_lights_designs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wall_paper_designs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wall_trim_designs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "water_closet_handle_designs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "colors", "materials"
  add_foreign_key "genres_products", "genres"
  add_foreign_key "genres_products", "products"
  add_foreign_key "product_sub_types", "product_types"
  add_foreign_key "products", "genres"
  add_foreign_key "products", "product_sub_types"
  add_foreign_key "products", "product_types"
  add_foreign_key "products", "styles"
  add_foreign_key "products_styles", "products"
  add_foreign_key "products_styles", "styles"
  add_foreign_key "skus", "basin_designs"
  add_foreign_key "skus", "ceiling_lights_designs"
  add_foreign_key "skus", "colors"
  add_foreign_key "skus", "console_counter_vanity_designs"
  add_foreign_key "skus", "door_trim_designs"
  add_foreign_key "skus", "genres"
  add_foreign_key "skus", "lever_designs"
  add_foreign_key "skus", "materials"
  add_foreign_key "skus", "overall_colors"
  add_foreign_key "skus", "product_sub_types"
  add_foreign_key "skus", "product_types"
  add_foreign_key "skus", "products"
  add_foreign_key "skus", "styles"
  add_foreign_key "skus", "wall_lights_designs"
  add_foreign_key "skus", "wall_paper_designs"
  add_foreign_key "skus", "wall_trim_designs"
  add_foreign_key "skus", "water_closet_handle_designs"
  add_foreign_key "styles", "genres"
end
