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

ActiveRecord::Schema.define(version: 20151124222236) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accents_products", force: :cascade do |t|
    t.integer "finish_id"
    t.integer "product_id"
  end

  add_index "accents_products", ["finish_id"], name: "index_accents_products_on_finish_id", using: :btree
  add_index "accents_products", ["product_id"], name: "index_accents_products_on_product_id", using: :btree

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

  create_table "china_colors", force: :cascade do |t|
    t.string   "name"
    t.string   "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "china_colors_product_groups", force: :cascade do |t|
    t.integer "china_color_id"
    t.integer "product_group_id"
  end

  add_index "china_colors_product_groups", ["china_color_id"], name: "index_china_colors_product_groups_on_china_color_id", using: :btree
  add_index "china_colors_product_groups", ["product_group_id"], name: "index_china_colors_product_groups_on_product_group_id", using: :btree

  create_table "china_colors_products", force: :cascade do |t|
    t.integer "product_id"
    t.integer "china_color_id"
  end

  add_index "china_colors_products", ["china_color_id"], name: "index_china_colors_products_on_china_color_id", using: :btree
  add_index "china_colors_products", ["product_id"], name: "index_china_colors_products_on_product_id", using: :btree

  create_table "compilations", force: :cascade do |t|
    t.string "name"
    t.string "number"
  end

  create_table "compilations_products", force: :cascade do |t|
    t.integer "compilation_id"
    t.integer "product_id"
  end

  add_index "compilations_products", ["compilation_id"], name: "index_compilations_products_on_compilation_id", using: :btree
  add_index "compilations_products", ["product_id"], name: "index_compilations_products_on_product_id", using: :btree

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

  create_table "filter_product_group_values", force: :cascade do |t|
    t.integer  "product_group_id"
    t.integer  "filter_id"
    t.integer  "filter_value_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "filter_product_group_values", ["filter_id"], name: "index_filter_product_group_values_on_filter_id", using: :btree
  add_index "filter_product_group_values", ["filter_value_id"], name: "index_filter_product_group_values_on_filter_value_id", using: :btree
  add_index "filter_product_group_values", ["product_group_id"], name: "index_filter_product_group_values_on_product_group_id", using: :btree

  create_table "filter_product_values", force: :cascade do |t|
    t.integer "product_id"
    t.integer "filter_id"
    t.integer "filter_value_id"
    t.integer "product_group_id"
  end

  add_index "filter_product_values", ["filter_id"], name: "index_filter_product_values_on_filter_id", using: :btree
  add_index "filter_product_values", ["filter_value_id"], name: "index_filter_product_values_on_filter_value_id", using: :btree
  add_index "filter_product_values", ["product_group_id"], name: "index_filter_product_values_on_product_group_id", using: :btree
  add_index "filter_product_values", ["product_id"], name: "index_filter_product_values_on_product_id", using: :btree

  create_table "filter_values", force: :cascade do |t|
    t.string  "name"
    t.integer "filter_id"
  end

  add_index "filter_values", ["filter_id"], name: "index_filter_values_on_filter_id", using: :btree

  create_table "filter_values_product_groups", force: :cascade do |t|
    t.integer "filter_value_id"
    t.integer "product_group_id"
  end

  add_index "filter_values_product_groups", ["filter_value_id"], name: "index_filter_values_product_groups_on_filter_value_id", using: :btree
  add_index "filter_values_product_groups", ["product_group_id"], name: "index_filter_values_product_groups_on_product_group_id", using: :btree

  create_table "filter_values_products", force: :cascade do |t|
    t.integer "product_id"
    t.integer "filter_value_id"
  end

  add_index "filter_values_products", ["filter_value_id"], name: "index_filter_values_products_on_filter_value_id", using: :btree
  add_index "filter_values_products", ["product_id"], name: "index_filter_values_products_on_product_id", using: :btree

  create_table "filters", force: :cascade do |t|
    t.string "name"
  end

  create_table "finishes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "identifier"
  end

  create_table "finishes_product_groups", force: :cascade do |t|
    t.integer "finish_id"
    t.integer "product_group_id"
  end

  add_index "finishes_product_groups", ["finish_id"], name: "index_finishes_product_groups_on_finish_id", using: :btree
  add_index "finishes_product_groups", ["product_group_id"], name: "index_finishes_product_groups_on_product_group_id", using: :btree

  create_table "finishes_products", force: :cascade do |t|
    t.integer "finish_id"
    t.integer "product_id"
  end

  add_index "finishes_products", ["finish_id"], name: "index_finishes_products_on_finish_id", using: :btree
  add_index "finishes_products", ["product_id"], name: "index_finishes_products_on_product_id", using: :btree

  create_table "genres", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres_product_groups", force: :cascade do |t|
    t.integer "genre_id"
    t.integer "product_group_id"
  end

  add_index "genres_product_groups", ["genre_id"], name: "index_genres_product_groups_on_genre_id", using: :btree
  add_index "genres_product_groups", ["product_group_id"], name: "index_genres_product_groups_on_product_group_id", using: :btree

  create_table "genres_products", force: :cascade do |t|
    t.integer "genre_id"
    t.integer "product_id"
  end

  add_index "genres_products", ["genre_id"], name: "index_genres_products_on_genre_id", using: :btree
  add_index "genres_products", ["product_id"], name: "index_genres_products_on_product_id", using: :btree

  create_table "inserts_products", force: :cascade do |t|
    t.integer "material_id"
    t.integer "product_id"
  end

  add_index "inserts_products", ["material_id"], name: "index_inserts_products_on_material_id", using: :btree
  add_index "inserts_products", ["product_id"], name: "index_inserts_products_on_product_id", using: :btree

  create_table "lever_designs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "materials", force: :cascade do |t|
    t.string  "name"
    t.boolean "is_insert"
    t.string  "material_type"
    t.string  "code"
    t.string  "identifier"
  end

  create_table "materials_product_groups", force: :cascade do |t|
    t.integer "material_id"
    t.integer "product_group_id"
  end

  add_index "materials_product_groups", ["material_id"], name: "index_materials_product_groups_on_material_id", using: :btree
  add_index "materials_product_groups", ["product_group_id"], name: "index_materials_product_groups_on_product_group_id", using: :btree

  create_table "materials_products", force: :cascade do |t|
    t.integer "product_id"
    t.integer "material_id"
  end

  add_index "materials_products", ["material_id"], name: "index_materials_products_on_material_id", using: :btree
  add_index "materials_products", ["product_id"], name: "index_materials_products_on_product_id", using: :btree

  create_table "overall_colors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_configurations", force: :cascade do |t|
    t.integer "product_id"
    t.string  "number"
  end

  add_index "product_configurations", ["product_id"], name: "index_product_configurations_on_product_id", using: :btree

  create_table "product_group_filters", force: :cascade do |t|
    t.integer "product_group_id"
    t.integer "filter_id"
  end

  add_index "product_group_filters", ["filter_id"], name: "index_product_group_filters_on_filter_id", using: :btree
  add_index "product_group_filters", ["product_group_id"], name: "index_product_group_filters_on_product_group_id", using: :btree

  create_table "product_groups", force: :cascade do |t|
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "name"
    t.integer  "product_type_id"
    t.integer  "product_sub_type_id"
    t.integer  "style_id"
    t.string   "number"
  end

  add_index "product_groups", ["product_sub_type_id"], name: "index_product_groups_on_product_sub_type_id", using: :btree
  add_index "product_groups", ["product_type_id"], name: "index_product_groups_on_product_type_id", using: :btree
  add_index "product_groups", ["style_id"], name: "index_product_groups_on_style_id", using: :btree

  create_table "product_groups_styles", force: :cascade do |t|
    t.integer "product_group_id"
    t.integer "style_id"
  end

  add_index "product_groups_styles", ["product_group_id"], name: "index_product_groups_styles_on_product_group_id", using: :btree
  add_index "product_groups_styles", ["style_id"], name: "index_product_groups_styles_on_style_id", using: :btree

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
    t.integer  "product_group_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "products", ["genre_id"], name: "index_products_on_genre_id", using: :btree
  add_index "products", ["product_group_id"], name: "index_products_on_product_group_id", using: :btree
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

  add_foreign_key "accents_products", "finishes"
  add_foreign_key "accents_products", "products"
  add_foreign_key "china_colors_product_groups", "china_colors"
  add_foreign_key "china_colors_product_groups", "product_groups"
  add_foreign_key "china_colors_products", "china_colors"
  add_foreign_key "china_colors_products", "products"
  add_foreign_key "compilations_products", "compilations"
  add_foreign_key "compilations_products", "products"
  add_foreign_key "filter_product_group_values", "filter_values"
  add_foreign_key "filter_product_group_values", "filters"
  add_foreign_key "filter_product_group_values", "product_groups"
  add_foreign_key "filter_product_values", "filter_values"
  add_foreign_key "filter_product_values", "filters"
  add_foreign_key "filter_product_values", "product_groups"
  add_foreign_key "filter_product_values", "products"
  add_foreign_key "filter_values", "filters"
  add_foreign_key "filter_values_product_groups", "filter_values"
  add_foreign_key "filter_values_product_groups", "product_groups"
  add_foreign_key "filter_values_products", "filter_values"
  add_foreign_key "filter_values_products", "products"
  add_foreign_key "finishes_product_groups", "finishes"
  add_foreign_key "finishes_product_groups", "product_groups"
  add_foreign_key "finishes_products", "finishes"
  add_foreign_key "finishes_products", "products"
  add_foreign_key "genres_product_groups", "genres"
  add_foreign_key "genres_product_groups", "product_groups"
  add_foreign_key "genres_products", "genres"
  add_foreign_key "genres_products", "products"
  add_foreign_key "inserts_products", "materials"
  add_foreign_key "inserts_products", "products"
  add_foreign_key "materials_product_groups", "materials"
  add_foreign_key "materials_product_groups", "product_groups"
  add_foreign_key "materials_products", "materials"
  add_foreign_key "materials_products", "products"
  add_foreign_key "product_configurations", "products"
  add_foreign_key "product_group_filters", "filters"
  add_foreign_key "product_group_filters", "product_groups"
  add_foreign_key "product_groups", "product_sub_types"
  add_foreign_key "product_groups", "product_types"
  add_foreign_key "product_groups", "styles"
  add_foreign_key "product_groups_styles", "product_groups"
  add_foreign_key "product_groups_styles", "styles"
  add_foreign_key "product_sub_types", "product_types"
  add_foreign_key "products", "genres"
  add_foreign_key "products", "product_groups"
  add_foreign_key "products", "product_sub_types"
  add_foreign_key "products", "product_types"
  add_foreign_key "products", "styles"
  add_foreign_key "products_styles", "products"
  add_foreign_key "products_styles", "styles"
  add_foreign_key "skus", "basin_designs"
  add_foreign_key "skus", "ceiling_lights_designs"
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
