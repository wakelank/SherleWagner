# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#
##Category.delete_all
#SubCategory.delete_all
#
#categories = %w(APOLLO ARCO GREY HARRISON MOLECULE NOUVEAU ONYX RIBBON\ &\ REED)
#sub_categories = %w(Accessories Fittings Fixtures Hardware Lighting)
#
#categories.each { |category| Category.create(name: category) }
#sub_categories.each { |sub_cat| SubCategory.create(name: sub_cat) }

Color.delete_all
Material.delete_all

materials = %w(Marble Semi-Precious\ Stone Onyx Florentine\ Finish Beaded Cut\ Crystal Gesso\ Wood)
colors = { marble:  
%w(SATIN\ BRASS
POLISHED\ BRASS
BRUSHED\ CHROME
POLISHED\ CHROME
BRUSHED\ NICKEL
POLISHED\ NICKEL
FLEMISH\ PATINA
ENGLISH\ PATINA
VERDI\ ANTIQUE
OIL\ RUBED\ BRASS
ANTIQUE\ PEWTER
GOLD\ PLATE
ANTIQUE\ GOLD
BURNISHED\ GOLD
ENGLISH\ SILVER
BURNISHED\ PLATINUM
BUTLER\ SILVER) }

materials.each do |material|
  Material.create(name: material)
end

colors.each do |material, colors|
  material = Material.where("lower(name) = ?",  material.to_s.downcase).first
  colors.each do |color|
    Color.create( name: color, material: material)
  end
end

