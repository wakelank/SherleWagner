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

ActiveRecord::Schema.define(version: 20160114161724) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "china_colors", force: :cascade do |t|
    t.string   "name"
    t.string   "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "china_colors_products", force: :cascade do |t|
    t.integer "product_id"
    t.integer "china_color_id"
  end

  add_index "china_colors_products", ["china_color_id"], name: "index_china_colors_products_on_china_color_id", using: :btree
  add_index "china_colors_products", ["product_id"], name: "index_china_colors_products_on_product_id", using: :btree

  create_table "compilation_relationships", force: :cascade do |t|
    t.integer  "component_id"
    t.integer  "compilation_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "compilation_relationships", ["compilation_id"], name: "index_compilation_relationships_on_compilation_id", using: :btree
  add_index "compilation_relationships", ["component_id"], name: "index_compilation_relationships_on_component_id", using: :btree

  create_table "compilations", force: :cascade do |t|
    t.string   "name"
    t.string   "number"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "compilations_products", force: :cascade do |t|
    t.integer "compilation_id"
    t.integer "product_id"
  end

  add_index "compilations_products", ["compilation_id"], name: "index_compilations_products_on_compilation_id", using: :btree
  add_index "compilations_products", ["product_id"], name: "index_compilations_products_on_product_id", using: :btree

  create_table "filter_values", force: :cascade do |t|
    t.string  "name"
    t.integer "filter_id"
  end

  add_index "filter_values", ["filter_id"], name: "index_filter_values_on_filter_id", using: :btree

  create_table "filter_values_products", force: :cascade do |t|
    t.integer "product_id"
    t.integer "filter_value_id"
  end

  add_index "filter_values_products", ["filter_value_id"], name: "index_filter_values_products_on_filter_value_id", using: :btree
  add_index "filter_values_products", ["product_id"], name: "index_filter_values_products_on_product_id", using: :btree

  create_table "filters", force: :cascade do |t|
    t.string "name"
  end

  create_table "filters_product_sub_types", force: :cascade do |t|
    t.integer "filter_id"
    t.integer "product_sub_type_id"
  end

  add_index "filters_product_sub_types", ["filter_id"], name: "index_filters_product_sub_types_on_filter_id", using: :btree
  add_index "filters_product_sub_types", ["product_sub_type_id"], name: "index_filters_product_sub_types_on_product_sub_type_id", using: :btree

  create_table "finishes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "identifier"
  end

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

  create_table "genres_products", force: :cascade do |t|
    t.integer "genre_id"
    t.integer "product_id"
  end

  add_index "genres_products", ["genre_id"], name: "index_genres_products_on_genre_id", using: :btree
  add_index "genres_products", ["product_id"], name: "index_genres_products_on_product_id", using: :btree

  create_table "materials", force: :cascade do |t|
    t.string  "name"
    t.boolean "is_insert"
    t.string  "material_type"
    t.string  "code"
    t.string  "identifier"
  end

  create_table "materials_products", force: :cascade do |t|
    t.integer "product_id"
    t.integer "material_id"
  end

  add_index "materials_products", ["material_id"], name: "index_materials_products_on_material_id", using: :btree
  add_index "materials_products", ["product_id"], name: "index_materials_products_on_product_id", using: :btree

  create_table "product_components", id: false, force: :cascade do |t|
    t.integer "product_a_id", null: false
    t.integer "product_b_id", null: false
  end

  create_table "product_configurations", force: :cascade do |t|
    t.integer  "product_id"
    t.string   "number"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "description"
  end

  add_index "product_configurations", ["product_id"], name: "index_product_configurations_on_product_id", using: :btree

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
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "product_type_id"
    t.integer  "product_sub_type_id"
    t.integer  "genre_id"
    t.integer  "style_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "associated_collection_id"
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

  create_table "styles", force: :cascade do |t|
    t.string   "name"
    t.integer  "genre_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "is_collection"
  end

  add_index "styles", ["genre_id"], name: "index_styles_on_genre_id", using: :btree

  add_foreign_key "china_colors_products", "china_colors"
  add_foreign_key "china_colors_products", "products"
  add_foreign_key "compilations_products", "compilations"
  add_foreign_key "compilations_products", "products"
  add_foreign_key "filter_values", "filters"
  add_foreign_key "filter_values_products", "filter_values"
  add_foreign_key "filter_values_products", "products"
  add_foreign_key "filters_product_sub_types", "filters"
  add_foreign_key "filters_product_sub_types", "product_sub_types"
  add_foreign_key "finishes_products", "finishes"
  add_foreign_key "finishes_products", "products"
  add_foreign_key "genres_products", "genres"
  add_foreign_key "genres_products", "products"
  add_foreign_key "materials_products", "materials"
  add_foreign_key "materials_products", "products"
  add_foreign_key "product_configurations", "products"
  add_foreign_key "product_sub_types", "product_types"
  add_foreign_key "products", "genres"
  add_foreign_key "products", "product_sub_types"
  add_foreign_key "products", "product_types"
  add_foreign_key "products", "styles"
  add_foreign_key "products_styles", "products"
  add_foreign_key "products_styles", "styles"
  add_foreign_key "styles", "genres"
end
