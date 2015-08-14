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

materials = %w(China Metal Marble SemiPrecious_Stone Onyx Florentine\ Finish Beaded Cut\ Crystal Gesso\ Wood)
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
            BUTLER\ SILVER),
          metal:
            %w(satin\ brass
            polished\ brass
            brushed\ chrome
            polished\ chrome
            brushed\ nickel
            polished\ nickel
            flemish\ patina
            english\ patina
            verdi\ antique
            oil\ rubed brass
            antique\ pewter
            gold\ plate
            antique\ gold
            burnished\ gold
            english\ silver
            burnished\ platinum
            butler\ silver),
          china:
            %w(SOLID\ PLAIN\ COLORS
            HAND\ DECORATE
            HAND\ PAINTED
            GOLD\ PLATINUM),
           semiprecious_stone:
            %w(ROCK\ CRYSTAL\ \(RKCR\)
            ROSE\ QUARTZ\ \(RSQU\)
            AMETHYST\ \(AMET\)
            LAPIS\ LAZULI\ \(LAPI\)
            MALACHITE\ \(MALA\)
            JASPER\ \(JASP\)
            BROWN\ TIGER\ EYE\ \(BRTI\)\ 
            BLUE\ TIGER\ EYE\ \(BLTI\)
            RHODOCHROSITE\ \(RHOD\)),
          onyx:
            %w(BLACK\ ONYX\ \(BKOX\)
            WHITE\ ONYX\ \(WHOX\)
            HONEY\ ONYX\ \(HNOX\)
            GREEN\ ONYX\ \(GROX\)
            PINK\ ONYX\ \(PKOX\)
            BROWN\ ONYX\ \(BROX\))
}
materials.each do |material|
  Material.create(name: material)
end

colors.each do |material, colors|
  material = Material.where("lower(name) = ?",  material.to_s.downcase).first
  colors.each do |color|
    Color.create( name: color, material: material)
  end
end

