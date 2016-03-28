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


  #Product.destroy_all
  Style.destroy_all
  Genre.destroy_all
  Material.destroy_all
  Finish.destroy_all
  ProductSubType.destroy_all
  ProductType.destroy_all
  FilterValue.destroy_all
  Filter.destroy_all
  ChinaColor.destroy_all
  #Compilation.destroy_all
#ProductConfiguration.destroy_all

finishes = [ 
  { name: 'Polished Nickel', identifier: 'PN' },
  { name: 'Polished Chrome', identifier: 'CP' },
  { name: 'English Silver', identifier: 'ES' },
  { name: 'Antique Pewter', identifier: 'AP' },
  { name: 'Black Pearl', identifier: 'PE' },
  { name: 'Brushed Nickel', identifier: 'BN' },
  { name: 'Brushed Chrome', identifier: 'BC' },
  { name: 'Butler Silver', identifier: 'BS' },
  { name: 'High Polished Platinum', identifier: 'HP' },
  { name: 'Gold Plate', identifier: 'GP' },
  { name: 'Burnished Gold', identifier: 'BG' },
  { name: 'Satin Brass', identifier: 'SB' },
  { name: 'Oil Rubbed Brass', identifier: 'OB' },
  { name: 'English Patina', identifier: 'EP' },
  { name: 'Almond Gold', identifier: 'AL' },
  { name: 'Antique Gold', identifier: 'AG' },
  { name: 'Polished Brass', identifier: 'PB' },
  { name: 'Flemish Patina', identifier: 'FP' },
  { name: 'Rose Gold', identifier: 'RG' }
]
img_mod_path = '/images/finishes2/modern/'
img_orn_path = '/images/finishes2/ornate/'

Finish.create!(name: 'non finish', identifier: '00')

finishes.each do |finish|
  Finish.create!(name: finish[:name], identifier: finish[:identifier], modern_swatch_url: img_mod_path + finish[:identifier] + '.jpg', ornate_swatch_url: img_orn_path + finish[:identifier] + '.jpg' )
end

materials = [{ type: "China-Hand Painted",
              code: "HANDPAINTED",
              entries: [{name: "Delft — (66DL)", identifier: "66DL" },
                      { name: "Waterlilies — (109W)", identifier: "109W" },
                      { name: "Lotus — (20GR)", identifier: "20GR" },
                      { name: "Lotus — (20BL)", identifier: "20BL" },
                      { name: "Oriental Flowers — (54)", identifier: "54" },
                      { name: "Artichoke — (107A)", identifier: "107A" },
                      { name: "Poppies — (69PP)", identifier: "69PP" },
                      { name: "Peaches — (111P)", identifier: "111P" },
                      { name: "Summer Garden — (51SG)", identifier: "51SG" },
                      { name: "Ming Blossom - (18YL)", identifier: "18YL" },
                      { name: "Ming Blossom — (18PK)", identifier: "18PK" },
                      { name: "Ming Blossom — (18BR)", identifier: "18BR" },
                      { name: "Ming Blossom — (18BL)", identifier: "18BL" },
                      { name: "Garlands And Leaves — (74GL)", identifier: "74GL" },
                      { name: "Mums Bouquet — (56GR)", identifier: "56GR" },
                      { name: "Mums Bouquet — (56BL)", identifier: "56BL" },
                      { name: "Chinoiserie - (60PK)", identifier: "60PK" },
                      { name: "Chinoiserie - (60GR)", identifier: "60GR" },
                      { name: "Chinoiserie - (60BL)", identifier: "60BL" },
                      { name: "Floral Chinoiserie - (61PK)", identifier: "61PK" },
                      { name: "Floral Chinoiserie - (61GR)", identifier: "61GR" },
                      { name: "Floral Chinoiserie - (61BL)", identifier: "61BL" }]
             },
             {type: "China-Hand Decorated",
              code: "CHINADECO",
              entries: [ { name: "Le Jardin - Garnet-89GA", identifier: "89GA" },
                       { name: "Le Jardin - Greige/Taupe-89GG", identifier: "89GG" },
                       { name: "Le Jardin - Sepia-89SP", identifier: "89SP" },
                       { name: "Le Jardin - Light Blue-89LB", identifier: "89LB" },
                       { name: "Le Jardin - Charcoal-89CH", identifier: "89CH" },
                       { name: "Le Jardin - Blue-89BL", identifier: "89BL" },
                       { name: "Le Jardin -Sage-89SG", identifier: "89SG" },
                       { name: "Acorn & Oakleaf - Garnet-99GA", identifier: "99GA" },
                       { name: "Acorn & Oakleaf - Greige/Taupe-99GG", identifier: "99GG" },
                       { name: "Acorn & Oakleaf - Sepia-99SP", identifier: "99SP" },
                       { name: "Acorn & Oakleaf - Light Blue-99LB", identifier: "99LB" },
                       { name: "Acorn & Oakleaf - Charcoal-99CH", identifier: "99CH" },
                       { name: "Acorn & Oakleaf - Blue-99BL", identifier: "99BL" },
                       { name: "Acorn & Oakleaf -Sage-99SG", identifier: "99SG" }]
             },



             {type: "Marble",
              code:"MARBL",            
              entries: [ { name: "ARABESCATO", identifier: "ARAB" },
                         { name: "CALCATTA", identifier: "CALA" },
                         { name: "CARNICO GREY", identifier: "CAGR" },
                         { name: "CARRERA", identifier: "CARR" },
                         { name: "CREMA MARFIL", identifier: "CREMA" },
                         { name: "IMPERADOR BROWN", identifier: "IMBR" },
                         { name: "MARIANELLA", identifier: "MARI" },
                         { name: "NEGRO MARQUINA", identifier: "NEMA " },
                         { name: "PORT LAURENT", identifier: "PRLT" },
                         { name: "PORTORO", identifier: "PORT" },
                         { name: "ROSA DU MONTE", identifier: "RSDM" },
                         { name: "ROSE AURORA", identifier: "RSAU" },
                         { name: "ROSE DU MONTE", identifier: "RSDM" },
                         { name: "RUVINA", identifier: "RUVI" },
                         { name: "VEREDI VIANA", identifier: "VERD" },
                         { name: "WHITE THASSOS", identifier: "THAS" }]
             },
             {type: "Semi-precious Stone",
              code: "SEMI",
              entries: [{ name: "ROCK CRYSTAL", identifier: "RKCR" },
                        { name: "ROSE\ QUARTZ\ \(RSQU\)", identifier: "RSQU" },
                        { name: "AMETHYST\ \(AMET\)", identifier: "AMET" }]
             },
             { type: "Semi-precious Laminate",
               code: "SLSL",
               entries: [{ name: "LAPIS\ LAZULI\ \(LAPI\)", identifier: "LAPI" },
                         { name: "MALACHITE\ \(MALA\)", identifier: "MALA" },
                         { name: "JASPER\ \(JASP\)", identifier: "JASP" },
                         { name: "BROWN\ TIGER\ EYE\ \(BRTI\)", identifier: "BRTI" },
                         { name: "BLUE\ TIGER\ EYE\ \(BLTI\)", identifier: "BLTI" },
                         { name: "RHODOCHROSITE\ \(RHOD\)", identifier: "RHOD" } ]
             },
             {type: "Onyx", 
              code: "ONYX",
              entries: [ { name: "BLACK\ ONYX\ \(BKOX\)", identifier: "BKOX" },
                         { name: "WHITE\ ONYX\ \(WHOX\)", identifier: "WHOX" },
                         { name: "HONEY\ ONYX\ \(HNOX\)", identifier: "HNOX" },
                         { name: "GREEN\ ONYX\ \(GROX\)", identifier: "GROX" },
                         { name: "PINK\ ONYX\ \(PKOX\)", identifier: "PKOX" },
                         { name: "BROWN\ ONYX\ \(BROX\)",  identifier: "BROX" }]
             },
             {type: "Glaze",
              code: "GLAZE",
              entries: [
                         {name: "White", identifier: "WHT" },
                         {name: "Sand", identifier: "SND" }],
             },
             {type: "Banded",
              code: "CHINABANDED",
              entries: [{ name: "Classic Lines with Gold", identifier: "8EN-G" },
                        { name:"Greek Key with gold", identifier: "1EN-G" },
                        { name:"Acanthus with gold", identifier: "2EN-G" },
                        { name:"Ribbon & Reed with gold", identifier: "3EN-G" },
                        { name:"Scroll with gold", identifier: "4EN-G" },
                        { name:"Renaissance with gold", identifier: "6EN-G" },
                        { name:"Napoleonic Bee with gold", identifier: "7EN-G" },
                        { name:"Imperial with gold", identifier: "9EN-G" },
                        { name:"English Ivy Lace with gold", identifier: "10EN-G" },
                        { name:"Rose Garland with gold", identifier: "11EN-G" },
                        { name:"Acorn Garland with gold", identifier: "12EN-G" },
                        { name:"Empire with gold", identifier: "21EN-G" },
                        { name:"Classic Lines with platinum", identifier: "8EN-P" },
                        { name:"Greek Key with platinum", identifier: "1EN-P" },
                        { name:"Acanthus with platinum", identifier: "2EN-P" },
                        { name:"Ribbon & Reed with platinum", identifier: "3EN-P" },
                        { name:"Scroll with platinum", identifier: "4EN-P" },
                        { name:"Renaissance with platinum", identifier: "6EN-P" },
                        { name:"Napoleonic Bee with platinum", identifier: "7EN-P" },
                        { name:"Imperial with platinum", identifier: "9EN-P" },
                        { name:"English Ivy Lace with platinum", identifier: "10EN-P" },
                        { name:"Rose Garland with platinum", identifier: "11EN-P" },
                        { name:"Acorn Garland with platinum", identifier: "12EN-P" },
                        { name:"Empire with platinum", identifier: "21EN-P" },
                        { name:"Randome Leaves with platinum", identifier: "25PL-P" },
                        { name:"Classic Lines with highly polished platinum", identifier: "8EN-HP" },
                        { name:"Greek Key with highly polished platinum", identifier: "1EN-HP" },
                        { name:"Acanthus with highly polished platinum", identifier: "2EN-HP" },
                        { name:"Ribbon & Reed with highly polished platinum", identifier: "3EN-HP" },
                        { name:"Scroll with highly polished platinum", identifier: "4EN-HP" },
                        { name:"Renaissance with highly polished platinum", identifier: "6EN-HP" },
                        { name:"Imperial with highly polished platinum", identifier: "9EN-HP" },
                        { name:"Empire with Highly polished platinum", identifier: "21EN-HP" } ]
              },
              {type: "China Metal Decorated",
               code: "METALDECO",
               entries: [
                 { name:"Masonry with gold", identifier: "MS-G" },
                 { name:"Modern Rings with gold", identifier: "MR-G" },
                 { name:"Fleur de Lis with gold", identifier: "5EN-G" },
                 { name:"Random Leaves with gold", identifier: "25-G" },
                 { name:"Masonry with platinum", identifier: "MS-P" },
                 { name:"Modern Rings with platinum", identifier: "MR-P" },
                 { name:"Fleur de Lis with platinum", identifier: "5EN-P" },
                 { name:"Fleur de Lis with highly polished platinum", identifier: "5EN-HP" },
                 { name:"Random Leaves with highly polished platinum", identifier: "25BK" }]
               },
               {type: "China Metal",
                code: "CHINAMETAL",
                entries: [{name: "Burnished Platinum, Solid", identifier: "15PL" },
                          {name: "Highly Polished Platinum, Solid", identifier: "17HP" },
                          {name: "Burnished Gold, Solid", identifier: "14GP" } ]
               }
            ]


Material.create!(material_type: "no type", name: "no name", code: "no code", identifier: '0000')


materials.each do |material|
  type = material[:type]
  code = material[:code]
  names = material[:names]
  material[:entries].each do |entry|
    Material.create!(material_type:type, name: entry[:name], code:code, identifier: entry[:identifier] )
  end
end



china_colors =  [ { name: "Sand", identifier: "SD" },
        { name: "White", identifier: "WH" },
        { name: "Black", identifier: "BL" }]

ChinaColor.create!(name: 'no name', identifier: '00')

china_colors.each do |china_color|
  name = china_color[:name]
  identifier = china_color[:identifier]
  ChinaColor.create!(name: name, identifier: identifier)
end








#materials = %w(China Metal Marble SemiPrecious_Stone Onyx Florentine\ Finish Beaded Cut\ Crystal Gesso\ Wood)
#colors = { marble:  
#            %w(ROSE\ AURORA\ \(RSAU\)
#            ROSE\ DU\ MONTE\ \(RSDM\)
#            CARARRA\ \(CARR\)
#            MARIANELLA\ \(MARI\)
#            ANTIQUE\ WHITE\ \(ANWH\)
#            ANTIQUE\ BROWN\ \(ANBR\)
#            ESTREMOZ\ \(ESTR\)
#            VERDI\ VIANA\ \(VERD\)
#            CREMA\ MARFIL\ \(CREMA\)\ 
#            BELGIAN\ BLACK\ \(BLGB\)
#            ROJO\ ALICANTE\ \(ROJO\)
#            BLACK\ MARBLE\ \(BLMA\)
#            ROSA\ LEVANTO\ \(RSLV\)
#            IMPERADOR\ BROWN\ \(IMBR\)
#            CARNICO\ GREY\ \(CRGR\)
#            ARABESCATO\ \(ARAB\)
#            NEGRO\ MARQUINA\ \(NEMA\)
#            PORTORO\ \(PORT\)
#            VALVERDE\ \(VLVD\)
#            CALACATTA\ \(CALA\)
#            PORT\ LAURENT\ \(PTLA\)),
#
#          metal:
#            %w(satin\ brass
#            polished\ brass
#            brushed\ chrome
#            polished\ chrome
#            brushed\ nickel
#            polished\ nickel
#            flemish\ patina
#            english\ patina
#            verdi\ antique
#            oil\ rubed brass
#            antique\ pewter
#            gold\ plate
#            antique\ gold
#            burnished\ gold
#            english\ silver
#            burnished\ platinum
#            butler\ silver),
#          china:
#            %w(SOLID\ PLAIN\ COLORS
#            HAND\ DECORATE
#            HAND\ PAINTED
#            GOLD\ PLATINUM),
#           semiprecious_stone:
#            %w(ROCK\ CRYSTAL\ \(RKCR\)
#            ROSE\ QUARTZ\ \(RSQU\)
#            AMETHYST\ \(AMET\)
#            LAPIS\ LAZULI\ \(LAPI\)
#            MALACHITE\ \(MALA\)
#            JASPER\ \(JASP\)
#            BROWN\ TIGER\ EYE\ \(BRTI\)\ 
#            BLUE\ TIGER\ EYE\ \(BLTI\)
#            RHODOCHROSITE\ \(RHOD\)),
#          onyx:
#            %w(BLACK\ ONYX\ \(BKOX\)
#            WHITE\ ONYX\ \(WHOX\)
#            HONEY\ ONYX\ \(HNOX\)
#            GREEN\ ONYX\ \(GROX\)
#            PINK\ ONYX\ \(PKOX\)
#            BROWN\ ONYX\ \(BROX\))
#}
#materials.each do |material|
#  Material.create(name: material)
#end

#colors.each do |material, colors|
#  material = Material.where("lower(name) = ?",  material.to_s.downcase).first
#  colors.each do |color|
#    Color.create( name: color, material: material)
#  end
#end

#types = %w(Fittings Accessories Fixtures Hardware Lights Wallcoverings)
#sub_types = { 
#  fittings:
#    %w(BASIN\ AND\ BAR\ SETS
#    TUB\ AND\ SHOWER\ COMPONENTS
#    WATER\ CLOSET\ AND\ BIDET\ FITTINGS),
#  accessories:
#    %w(BATHROOM
#    COUNTER\ TOPS
#    MEDICISNE\ CABINETS),
#  fixtures:
#    %w(SINKS
#    PEDESTAL
#    CONSOLES,\ COUNTERS\ AND\ VANITIES
#    TUBS
#    WAER\ CLOSET\ AND\ BIDET\ FIXTURES),
#  lights:
#    %w(CEILING\ LIGHTS
#    CABINET\ AND\ DRAWER\ PULLS),
#  wallcoverings:
#    %w(WALLPAPERS
#    CERAMIC
#    MARBLE),
#  hardware:
#    %w(LEVERS\ AND\ KNOBS CABINET\ &\ DRAWER\ PULLS DOOR\ TRIM WALL\ TRIM)
#}

types = [
  { name: "Fittings",
           sub_types: [
            { name: "Basin Sets"},
            { name: "Bar Spout Basin Sets"},
            { name: "Single Handle Basin Sets"},
            { name: "Wall Mount Basin Sets"},
            { name: "Shower Systems"},
            { name: "Deck Mount Tub Sets"},
            { name: "Wall Mount Tub Sets"},
            { name: "Exposed Tub Sets"},
            { name: "Exposed Shower Sets"},
            { name: "Bidet Sets"},
            { name: "Trip Levers"},
            { name: "Components"}
           ]
          
  },
  { name: "Fixtures", 
             sub_types: [
                { name: "Basins" },
                { name: "Pedestals" },
                { name: "Counters" },
                { name: "Consoles" },
                { name: "Legs" },
                { name: "Tubs" },
                { name: "Water Closets" },
                { name: "Bidets" }
              ]
            
  },
  { name: "Accessories",
             sub_types: [
                { name: "Towel Bars" },
                { name: "Shelves" },
                { name: "Towel Rings" },
                { name: "Paper Holders" },
                { name: "Hooks" },
                { name: "Holders, Baskets" },
                { name: "Grab Bars" },
                { name: "Mirrors & Medicine Cabinets" },
                { name: "Tub and Shower" },
                { name: "Countertop Accessories" },
                { name: "Decorative Objects" },
                { name: "Benches" },
                { name: "Toilet Brush & China Holders" }
              ]
            
  },
  { name: "Hardware",
               sub_types: [
                  { name: "Door Levers" },
                  { name: "Door Knobs" },
                  { name: "Elongated Back Plate Systems" },
                  { name: "Back Plates" },
                  { name: "Push Plates" },
                  { name: "Flush Pulls" },
                  { name: "Hinges" },
                  { name: "Cremone Bolts" },
                  { name: "Slide Bolts" },
                  { name: "Bar Pulls" },
                  { name: "Cabinet and Drawer Knobs" },
                  { name: "Door Bell Covers" },
                  { name: "Door Stops" },
                  { name: "Cylinder Covers" },
                  { name: "Keyhole Covers" },
                  { name: "Decorative Box Lock Covers" },
                  { name: "Thumb Turns" },
                  { name: "Latches" },
                ]
              
  },
  { name: "Lighting",
             sub_types: [
                { name: "Ceiling Lights" },
                { name: "Wall Lights" },
                { name: "Table and Floor Lights" },
                { name: "Electrical Covers" },
                { name: "Bulb Covers" }
              ]
            
  },

  # #TODO lighting filters
  { name: "Wallpaper",
             sub_types: [
                { name: "Masonry" },
                { name: "Masonry Stripe" },
                { name: "Modern Rings" },
                { name: "Modern Rings Stripe" },
                { name: "Textured Stripe" },
                { name: "English Country Tartan" },
                { name: "English Country Manor" },
                { name: "English Country Cameo" },
                { name: "Le Jardin" },
                { name: "Acorn & Oak Leaf Toile" },
                { name: "Simply Delft" },
                { name: "Delft" },
                { name: "Acanthus" },
                { name: "Louis Damask" },
                { name: "Ming Blossom" },
                { name: "Chinoiserie" },
                { name: "Summer Garden" },
                { name: "Lotus" },
                { name: "Kamalama Cay Lattice" },
                { name: "Kamalama Cay Stripe" },
                { name: "Poppies" },
                { name: "Summer Garden" },
                { name: "Artichoke" },
                { name: "Waterlilies" },
                { name: "Mums" }
              ]
            
  }
]

pt = ProductType.create!(name: 'no type')
ProductSubType.create!(name: 'no sub type', product_type: pt)


types.each do |type|
  new_type = ProductType.create!(name: type[:name])
  type[:sub_types].each do |sub_type|
    ProductSubType.create!(name: sub_type[:name], product_type: new_type)
  end
end


genres_styles = [
  { genre_name: "Contemporary",
    styles: [ "Arco", "Molecule", "Apollo", "Nouveau" ]
  },
  { genre_name: "Classic",
    styles: [ "Harrison", "Grey" ]
  },
  { genre_name: "Traditional",
    styles: [ "Ribbon & Reed", "Onyx", "Scalloped China" ]
  },
  { genre_name: "Ornate",
    styles: [ "Dolphin", "Swan", "Semiprecious Leaves" ]
  }
]

Genre.create!(name: "No genre")
Style.create!(name: "no style")

genres_styles.each do |genre_style|
  genre = Genre.create!(name: genre_style[:genre_name])
  genre_style[:styles].each do |style|
    genre.styles << Style.create!(name: style)
  end
end

filters = [
  { name: "Handle Design",
    filter_values: [ "Levers", "Knobs" ]
  },
  { name: "Shower Type",
    filter_values: [ "Concentric Thermostatic Shower Systems", "High Flow Thermostatic Shower Systems" ]
  },
  { name: "Type",
    filter_values: [ "Under Edge", "Over Edge" ]
  },
  { name: "Bidet Design",
    filter_values: [ "Two Hole", "Four Hole" ]
  },
  { name: "Console or Counter",
    filter_values: ["Consoles", "Counters", "Legs" ]
  },
  { name: "Trim Type",
    filter_values: [ "Concentric Thermostatic Trim", "High Flow Thermostatic Trim"]
  },
  { name: "Component Type",
    filter_values: [ "Volume Controls",
                      "Ceiling Shower Heads",
                      "Shower Heads",
                      "Rain Bars",
                      "Body Sprays",
                      "Rain Bars",
                      "Hand Showers",
                      "Wall Mount Spouts",
                      "Deck Mount Tub Spouts",
                      "Telephone Cradles",
                      "Supplies and Shut Offs"
                     ]
  },
  { name: "Paper Holder Design",
    filter_values: [ "Single Post", "Double Post", "Wall Mount" ]
  },
  { name: "Countertop Accessory Types",
    filter_values: [ "Tumblers ­ inside counter top",
                     "Soap Dishes",
                     "Boutique Tissue Box Covers",
                     "Elongated Tissue Box Covers",
                     "Covered Jars"]
  },
  { name: "Hinge Types",
    filter_values: [ "Paumelle Hinge", "Butt Hinge"]
  },
  { name: "Wallpaper Design",
    filter_values: [ "Toiles", "Floral", "Geometric" ]
  },
  { name: "Wallpaper Color",
    filter_values: [ "Neutral", "Blue", "Pink", "Yellow", "Black", "Red", "Green", "Metallic" ]
  },
  { name: "Glazed",
    filter_values: [ "Solid", "Hand Painted", "Hand Decorated"]
  },
  { name: "Burnished & Polished",
    filter_values: ["Banded", "Solid", "Decorated" ]
  },
  { name: "Sink Shape",
    filter_values: [ "Oval", "Round", "Geometric" ]
  },

  { name: "China",
    filter_values: [ "Hand_Painted", "Hand_Decorated"]
  },
  { name: "Materials",
    filter_values: [ "Metal", "China", "Onyx", "Semi_Precious", "Stone" ]
  },
  { name: "Ceiling Lights",
    filter_values: [ "Chandeliers", "Pendants", "Flush Mount"]
  },
  { name: "Wall Lights",
    filter_values: [ "Sconces", "Panel Lights", "Flush Mount"]
  }
]
genre_filter_hash = { name: "Styles" }
genre_filter_hash[:filter_values] = genres_styles.map { |style| style[:genre_name] }

filters << genre_filter_hash


Filter.create!(name: "no filter").filter_values << FilterValue.create!(name: "no filter value")

filters.each do |filter|
  this_filter = Filter.create!( name: filter[:name] )
  filter[:filter_values].each do |filter_value|
    this_filter.filter_values << FilterValue.create!(name: filter_value)
  end
end

ProductType.find_by(name: "Fittings").product_sub_types.each do |sub_type|
  sub_type.filters << Filter.find_by(name: "Handle Design")
end
fixtures = ProductType.where(name: "Fixtures")

ProductSubType.where(product_type: fixtures).where.not(name: "Legs").each do |product_sub_type|
  product_sub_type.filters << Filter.find_by(name: "Glazed")
end

ProductSubType.where(product_type: fixtures).
  where.not(name: "Legs").
  where.not(name: "Basins").
  where.not(name: "Consoles").each do |product_sub_type|
  product_sub_type.filters << Filter.find_by(name: "China")
end

ProductSubType.where.not(product_type: fixtures).each do |product_sub_type|
  product_sub_type.filters << Filter.find_by(name: "Materials")
end

ProductSubType.all.each do |product_sub_type|
  product_sub_type.filters << Filter.find_by(name: "Styles")
  case product_sub_type.name
  when "Bidet Sets"
    product_sub_type.filters << Filter.find_by(name: "Bidet Design")
  when "Shower Systems"
    product_sub_type.filters << Filter.find_by(name: "Shower Type")
  when "Components"
    product_sub_type.filters << Filter.find_by(name: "Trim Type")
    product_sub_type.filters << Filter.find_by(name: "Component Type")
  when "Basins"
    product_sub_type.filters << Filter.find_by(name: "Type")
    product_sub_type.filters << Filter.find_by(name: "Sink Shape")
    product_sub_type.filters << Filter.find_by(name: "Burnished & Polished")
  when "Paper Holders"
    product_sub_type.filters << Filter.find_by(name: "Paper Holder Design")
  when "Countertop Accessories"
    product_sub_type.filters << Filter.find_by(name: "Countertop Accessory Types")
  when "Hinges"
    product_sub_type.filters << Filter.find_by(name: "Hinge Types")
  when "Wallpaper"
    product_sub_type.filters << Filter.find_by(name: "Wallpaper Design")
    product_sub_type.filters << Filter.find_by(name: "Wallpaper Color")
  when "Ceiling Lights"
    product_sub_type.filters << Filter.find_by(name: "Ceiling Lights")
  when "Wall Lights"
    product_sub_type.filters << Filter.find_by(name: "Wall Lights")
  end
end


#end
#
#sub_types.each do |type, sub_types|
#  type = ProductType.where("lower(name) = ?",  type.to_s.downcase).first



#overall_colors = %w(Neutral Blues Pinks Yellows Blacks Reds Greens Metallics)
#
#overall_colors.each do |color|
#  OverallColor.create(name: color)
#end

#lever_designs = %w(Handle Knob)
#basin_designs = %w(Under\ edges Over\Edge)
#ccv_designs = %w(Console Counter Vanity)
#wc_handle_designs = %w(Drop\ pull Bar\ pull)
#door_trim_designs = %w(Push\ plates  Back\ Plates  Hinges  Latches Thumb\ turns  Flush\ pulls  Key\ hole\ cover)
#wall_trim_designs = %w(Door\ stops Bell\ Covers  Electrical\ plates)
#ceiling_lights_designs = %w(Chandeliers  Flush\ Mounted)
#wall_lights_designs = %w(Sconces Panel\ lights)
#wallpaper_designs = %w(Toiles Floral Geometric)
#
#lever_designs.each { |design| LeverDesign.create(name: design) }
#basin_designs.each { |design| BasinDesign.create(name: design) }
#ccv_designs.each { |design| ConsoleCounterVanityDesign.create(name: design) }
#wc_handle_designs.each { |design| WaterClosetHandleDesign.create(name: design) }
##Not for water closets. should be for drawer pulls
#door_trim_designs.each { |design| DoorTrimDesign.create(name: design) }
#wall_trim_designs.each { |design| WallTrimDesign.create(name: design) }
#ceiling_lights_designs.each { |design| CeilingLightsDesign.create(name: design) }
#wall_lights_designs.each { |design| WallLightsDesign.create(name: design) }
#wallpaper_designs.each { |design| WallPaperDesign.create(name: design) }
##add accessories bathrooms, countertops filters

num_products = 200

#num_products.times do
#  product_name = Faker::Commerce.product_name
#  long_description = Faker::Lorem.paragraph(5, false, 4)
#  product_number = Faker::Company.duns_number
#  product_type = ProductType.all.sample
#  product_sub_type = product_type.product_sub_types.sample
#  product = Product.create(name: product_name,
#                           long_description: long_description,
#                           number: product_number,
#                           product_type: product_type,
#                           product_sub_type: product_sub_type)
#  num_skus = rand(10)
#  num_skus.times do
#    sku_number = Faker::Company.duns_number
#    material = Material.all.sample
#    color = material.colors.sample
#    genre = Genre.all.sample
#    style = genre.styles.sample
#    product_type = ProductType.all.sample
#    product_sub_type = product_type.product_sub_types.sample
#    sku = Sku.create(material: material,
#               color: color,
#               genre: genre,
#               style: style,
#               number: sku_number)
#
#    case product.product_sub_type.name.downcase
#    when 'basin and bar sets'
#      sku.lever_design = LeverDesign.all.sample
#    when 'sinks'
#      sku.basin_design = BasinDesign.all.sample
#    when 'counter, console, vanity'
#      sku.counter_console_vanity_design = CounterConsoleVanity.all.sample
#    when 'door trim'
#      sku.door_trim_design = DoorTrimDesign.all.sample
#    when 'wall trim'
#      sku.wall_trim_design = WallTrimDesign.all.sample
#    when 'ceiling lights'
#      sku.ceiling_lights_design = CeilingLightsDesign.all.sample
#    when 'wall lights'
#      sku.wall_lights.design = WallLightsDesign.all.sample
#    when 'wallpaper'
#      sku.wallpaper_design = WallPaperDesign.all.sample
#    end
#    sku.save
#
#
#
#    product.skus << sku = sku
#  end
#end



#  end
#end


