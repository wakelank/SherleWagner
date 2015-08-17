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
ProductSubType.delete_all
ProductType.delete_all

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

types = %w(Fittings Accessories Fixtures Hardware Lights Wallcoverings)
sub_types = { 
  fittings:
    %w(BASIN\ AND\ BAR\ SETS
    TUB\ AND\ SHOWER\ COMPONENTS
    WATER\ CLOSET\ AND\ BIDET\ FITTINGS),
  accessories:
    %w(BATHROOM
    COUNTER\ TOPS
    MEDICISNE\ CABINETS),
  fixtures:
    %w(SINKS
    PEDESTAL
    CONSOLES,\ COUNTERS\ AND\ VANITIES
    TUBS
    WAER\ CLOSET\ AND\ BIDET\ FIXTURES),
  lights:
    %w(CEILING\ LIGHTS
    CABINET\ AND\ DRAWER\ PULLS),
  wallcoverings:
    %w(WALLPAPERS
    CERAMIC
    MARBLE)
}

types.each do |type|
  ProductType.create(name: type)
end

sub_types.each do |type, sub_types|
  type = ProductType.where("lower(name) = ?",  type.to_s.downcase).first
  sub_types.each do |sub_type|
    ProductSubType.create( name: sub_type, product_type: type)
  end
end

genres = %w(Ornate Traditional Classic MidCentury Contemporary)
styles = {
            ornate: 
              %w(LOUIS\ SEIZE
              CHERUB
              SWAN
              DOLPHIN
              FILIGREE
              1040\ LEAVES\ RSQU),
            traditional:
              %w(ACANTHUS
              RIBBON\ &\ REED
              CUT\ CRYSTAL
              CLASSIC
              MING\ BLOSSOM
              ONYX
              1029\ ROCK\ CRYSTAL),
            classic:
              %w(HARRISON
              GREY
              CLASSIC
              MELON),
            MidCentury:
              %w(APOLLO
              NOUVEAU
              COSMOS
              MOLECULES
              PYRAMID),
            Contemporary:
              %w(ARCO
              NAIAD
              AQUEDUCT
              ARBOR)
}
genres.each do |type|
  Genre.create(name: type)
end

styles.each do |genre, styles|
  genre = Genre.where("lower(name) = ?",  genre.to_s.downcase).first
  styles.each do |style|
    Style.create( name: style, genre: genre)
  end
end

overall_colors = %w(Neutral Blues Pinks Yellows Blacks Reds Greens Metallics)

overall_colors.each do |color|
  OverallColor.create(name: color)
end

