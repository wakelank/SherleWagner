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

Sku.delete_all
Product.delete_all
Color.delete_all
Material.delete_all
ProductSubType.delete_all
ProductType.delete_all
LeverDesign.delete_all
BasinDesign.delete_all
ConsoleCounterVanityDesign.delete_all
WaterClosetHandleDesign.delete_all
DoorTrimDesign.delete_all
WallTrimDesign.delete_all
CeilingLightsDesign.delete_all
WallLightsDesign.delete_all
WallPaperDesign.delete_all

materials = %w(China Metal Marble SemiPrecious_Stone Onyx Florentine\ Finish Beaded Cut\ Crystal Gesso\ Wood)
colors = { marble:  
            %w(ROSE\ AURORA\ \(RSAU\)
            ROSE\ DU\ MONTE\ \(RSDM\)
            CARARRA\ \(CARR\)
            MARIANELLA\ \(MARI\)
            ANTIQUE\ WHITE\ \(ANWH\)
            ANTIQUE\ BROWN\ \(ANBR\)
            ESTREMOZ\ \(ESTR\)
            VERDI\ VIANA\ \(VERD\)
            CREMA\ MARFIL\ \(CREMA\)\ 
            BELGIAN\ BLACK\ \(BLGB\)
            ROJO\ ALICANTE\ \(ROJO\)
            BLACK\ MARBLE\ \(BLMA\)
            ROSA\ LEVANTO\ \(RSLV\)
            IMPERADOR\ BROWN\ \(IMBR\)
            CARNICO\ GREY\ \(CRGR\)
            ARABESCATO\ \(ARAB\)
            NEGRO\ MARQUINA\ \(NEMA\)
            PORTORO\ \(PORT\)
            VALVERDE\ \(VLVD\)
            CALACATTA\ \(CALA\)
            PORT\ LAURENT\ \(PTLA\)),

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
    MARBLE),
  hardware:
    %w(LEVERS\ AND\ KNOBS CABINET\ &\ DRAWER\ PULLS DOOR\ TRIM WALL\ TRIM)
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

lever_designs = %w(Handle Knob)
basin_designs = %w(Under\ edges Over\Edge)
ccv_designs = %w(Console Counter Vanity)
wc_handle_designs = %w(Drop\ pull Bar\ pull)
door_trim_designs = %w(Push\ plates	Back\ Plates	Hinges	Latches	Thumb\ turns	Flush\ pulls	Key\ hole\ cover)
wall_trim_designs = %w(Door\ stops	Bell\ Covers	Electrical\ plates)
ceiling_lights_designs = %w(Chandeliers	Flush\ Mounted)
wall_lights_designs = %w(Sconces Panel\ lights)
wallpaper_designs = %w(Toiles Floral Geometric)

lever_designs.each { |design| LeverDesign.create(name: design) }
basin_designs.each { |design| BasinDesign.create(name: design) }
ccv_designs.each { |design| ConsoleCounterVanityDesign.create(name: design) }
wc_handle_designs.each { |design| WaterClosetHandleDesign.create(name: design) }
#Not for water closets. should be for drawer pulls
door_trim_designs.each { |design| DoorTrimDesign.create(name: design) }
wall_trim_designs.each { |design| WallTrimDesign.create(name: design) }
ceiling_lights_designs.each { |design| CeilingLightsDesign.create(name: design) }
wall_lights_designs.each { |design| WallLightsDesign.create(name: design) }
wallpaper_designs.each { |design| WallPaperDesign.create(name: design) }
#add accessories bathrooms, countertops filters

num_products = 200

num_products.times do
  product_name = Faker::Commerce.product_name
  long_description = Faker::Lorem.paragraph(5, false, 4)
  product_number = Faker::Company.duns_number
  product_type = ProductType.all.sample
  product_sub_type = product_type.product_sub_types.sample
  product = Product.create(name: product_name,
                           long_description: long_description,
                           number: product_number,
                           product_type: product_type,
                           product_sub_type: product_sub_type)
  num_skus = rand(10)
  num_skus.times do
    sku_number = Faker::Company.duns_number
    material = Material.all.sample
    color = material.colors.sample
    genre = Genre.all.sample
    style = genre.styles.sample
    product_type = ProductType.all.sample
    product_sub_type = product_type.product_sub_types.sample
    sku = Sku.create(material: material,
               color: color,
               genre: genre,
               style: style,
               number: sku_number)

    case product.product_sub_type.name.downcase
    when 'basin and bar sets'
      sku.lever_design = LeverDesign.all.sample
    when 'sinks'
      sku.basin_design = BasinDesign.all.sample
    when 'counter, console, vanity'
      sku.counter_console_vanity_design = CounterConsoleVanity.all.sample
    when 'door trim'
      sku.door_trim_design = DoorTrimDesign.all.sample
    when 'wall trim'
      sku.wall_trim_design = WallTrimDesign.all.sample
    when 'ceiling lights'
      sku.ceiling_lights_design = CeilingLightsDesign.all.sample
    when 'wall lights'
      sku.wall_lights.design = WallLightsDesign.all.sample
    when 'wallpaper'
      sku.wallpaper_design = WallPaperDesign.all.sample
    end
    sku.save



    product.skus << sku = sku
  end
end


