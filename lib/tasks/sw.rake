namespace :sw do
  desc "Each wallpaper gets all sub categoriy buddies as a configuration"
  task wallpaper_configs: :environment do

    wallpapers = ProductType.find_by_name("Wallpaper").products
      wallpapers.each do |wallpaper|

        wallpaper.product_configurations = []
        
        puts "#{wallpaper.name}"
        if wallpaper.product_sub_type.name != "no sub type"
          wallpaper.product_configurations.concat wallpaper.sub_type_buddies.map { |wp| wp.to_configuration }
        end
        wallpaper.save
        puts "Saved"
      end
    end

  desc "Assign images to wallpapers"
  task wallpaper_images: :environment do
   bucket = AwsHelper.new('sw-raw-images-color') 
    wallpapers = ProductType.find_by_name("Wallpaper").products
    wallpapers.each do |wallpaper|
      puts "#{wallpaper.name}"
      wallpaper.image = bucket.get_image_from_aws(wallpaper.number)
      wallpaper.product_configurations.each do |config|
        puts "config: #{config.number}"
        config.image = bucket.get_image_from_aws(config.number)

        config.save
      end
      wallpaper.save
    end
  end


  desc "Assign material swatches images"
  task material_swatches: :environment do
    bucket = AWS::S3.new().buckets['sw-raw-images']
    objects = bucket.objects
    Material.all.each do |mat|
      selected = objects.select do |obj|
        folder = obj.key.split('/').first
        filename = obj.key.split('/').last
        folder == "INTRODUCTION & FINISHES" && filename.include?(mat.identifier)
      end
      mat.swatch = selected.first.public_url if selected.count > 0
      mat.save
      puts "#{mat.name}: #{mat.identifier}"
      puts mat.swatch.url
    end
  end

  desc "capitalizes the first letter of each word in every product name" 
  task cap_prod_names: :environment do
    Product.all.each do |product|
      old_name = product.name
      product.name = product.name.split.map(&:capitalize).join(' ')
      product.save
      puts "#{old_name} -> #{product.name}"
    end
  end

  desc "assings marble and onyx materials to all products with 'stone' in the number"
  task stone_materials: :environment do
    stone_materials = Material.where(code: 'ONYX').concat Material.where(code: "MARBL")
    Product.all.each do |product|
      if product.number.include? 'STONE'
        product.materials << stone_materials
        product.save
        puts product.name
      end
    end
  end

  desc "assign tall to image_types for certain product sub_types"
  task tall_images: :environment do
    sub_types = ["Shower Systems",
                 "Exposed Tub and Shower sets",
                 "Exposed Shower Sets",
                 "Rain Bars", 
                 "Supplies",
                 "Shut offs",
                 "Pedestals",
                 "Counters",
                 "Consoles",
                 "Legs",
                 "Water Closets",
                 "Bidets",
                 "Toilet Brush Holders",
                 "Decorative Objects",
                 "Elongated Back Plate Systems",
                 "Push Plates",
                 "Back Plates",
                 "Cremone Bolts",
                 "Flush Pulls",
                 "Chandeliers",
                 "Pendant Lights",
                 "Table Lights and Floor Lights"
    ]
    sub_types.each do |sub_type_name|
      sub_type = ProductSubType.where('lower(name) = ?', sub_type_name.downcase).try(:first)
      if sub_type
        sub_type.products.each do |product|
          product.image_type = 'tall'
          product.save
          puts "#{sub_type.name}: #{product.name}"
        end
      end
    end
  end

  desc "sets page_section attribute for each product based on the genre"
  task set_section: :environment do
    section_assignments = { Contemporary: "A", Classic: "B", Traditional: "C", Ornate: "D" }
    section_assignments.each do |genre, section|
      genre_obj = Genre.find_by_name genre.to_s
      begin
      genre_obj.products.update_all(page_section: section)
      rescue 
        Rails.logger.error "Cannot find genre: #{genre.to_s}"
      end
    end

    desc "assign tall images to wallpapers"
    task tall_images_wallpapaer: :environment do
      wallpaper = ProductType.find_by_name "Wallpaper"
      Product.where(product_type: wallpaper).update_all(image_type: 'tall')

    end
  end
end
