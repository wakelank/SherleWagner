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

ActiveRecord::Schema.define(version: 20160510191813) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "associated_compilations", id: false, force: :cascade do |t|
    t.integer "compilation_a_id", null: false
    t.integer "compilation_b_id", null: false
  end

  create_table "china_colors", force: :cascade do |t|
    t.string   "name"
    t.string   "identifier"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
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

  create_table "environment_shot_styles", force: :cascade do |t|
    t.integer "environment_shot_id"
    t.integer "style_id"
  end

  add_index "environment_shot_styles", ["environment_shot_id"], name: "index_environment_shot_styles_on_environment_shot_id", using: :btree
  add_index "environment_shot_styles", ["style_id"], name: "index_environment_shot_styles_on_style_id", using: :btree

  create_table "environment_shots", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

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
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "identifier"
    t.string   "modern_swatch_url"
    t.string   "ornate_swatch_url"
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
    t.string   "name"
    t.boolean  "is_insert"
    t.string   "material_type"
    t.string   "code"
    t.string   "identifier"
    t.string   "swatch_file_name"
    t.string   "swatch_content_type"
    t.integer  "swatch_file_size"
    t.datetime "swatch_updated_at"
  end

  create_table "materials_products", force: :cascade do |t|
    t.integer "product_id"
    t.integer "material_id"
  end

  add_index "materials_products", ["material_id"], name: "index_materials_products_on_material_id", using: :btree
  add_index "materials_products", ["product_id"], name: "index_materials_products_on_product_id", using: :btree

  create_table "name_only_prod_prod_configs", force: :cascade do |t|
    t.integer "name_only_product_id"
    t.integer "product_configuration_id"
  end

  add_index "name_only_prod_prod_configs", ["name_only_product_id"], name: "index_name_only_prod_prod_configs_on_name_only_product_id", using: :btree
  add_index "name_only_prod_prod_configs", ["product_configuration_id"], name: "index_name_only_prod_prod_configs_on_product_configuration_id", using: :btree

  create_table "name_only_products", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "product_id"
  end

  add_index "name_only_products", ["product_id"], name: "index_name_only_products_on_product_id", using: :btree

  create_table "other_images", force: :cascade do |t|
    t.integer  "product_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "other_images", ["product_id"], name: "index_other_images_on_product_id", using: :btree

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "pg_search_documents", ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id", using: :btree

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
    t.integer  "name_only_product_id"
    t.boolean  "default"
  end

  add_index "product_configurations", ["name_only_product_id"], name: "index_product_configurations_on_name_only_product_id", using: :btree
  add_index "product_configurations", ["product_id"], name: "index_product_configurations_on_product_id", using: :btree

  create_table "product_images", force: :cascade do |t|
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "product_images", ["product_id"], name: "index_product_images_on_product_id", using: :btree

  create_table "product_sub_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "product_type_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
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
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.integer  "product_type_id"
    t.integer  "product_sub_type_id"
    t.integer  "genre_id"
    t.integer  "style_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "associated_collection_id"
    t.string   "display_size_for_collection", default: "small"
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
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.boolean  "is_collection"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "styles", ["genre_id"], name: "index_styles_on_genre_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "china_colors_products", "china_colors"
  add_foreign_key "china_colors_products", "products"
  add_foreign_key "compilations_products", "compilations"
  add_foreign_key "compilations_products", "products"
  add_foreign_key "environment_shot_styles", "environment_shots"
  add_foreign_key "environment_shot_styles", "styles"
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
  add_foreign_key "name_only_prod_prod_configs", "name_only_products"
  add_foreign_key "name_only_prod_prod_configs", "product_configurations"
  add_foreign_key "name_only_products", "products"
  add_foreign_key "other_images", "products"
  add_foreign_key "product_configurations", "name_only_products"
  add_foreign_key "product_configurations", "products"
  add_foreign_key "product_images", "products"
  add_foreign_key "product_sub_types", "product_types"
  add_foreign_key "products", "genres"
  add_foreign_key "products", "product_sub_types"
  add_foreign_key "products", "product_types"
  add_foreign_key "products", "styles"
  add_foreign_key "products_styles", "products"
  add_foreign_key "products_styles", "styles"
  add_foreign_key "styles", "genres"
end
