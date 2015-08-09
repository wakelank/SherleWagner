# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.delete_all
SubCategory.delete_all

categories = %w(APOLLO ARCO GREY HARRISON MOLECULE NOUVEAU ONYX RIBBON\ &\ REED)
sub_categories = %w(Accessories Fittings Fixtures Hardware Lighting)

categories.each { |category| Category.create(name: category) }
sub_categories.each { |sub_cat| SubCategory.create(name: sub_cat) }

