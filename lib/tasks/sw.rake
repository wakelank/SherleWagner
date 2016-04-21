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
    bucket = AWS::S3.new().bucket['sw-raw-images']
    objects = bucket.objects
    Material.all.each do |mat|
      objects.select do |obj|
        folder = obj.split('/').first
        filename = obj.split('/').last
        folder == "INTRODUCTION & FINISHES" && filename.include?(mat.identifier)
      end
      mat.swatch = objects.first.public_url
      mat.save
    end
  end
end
