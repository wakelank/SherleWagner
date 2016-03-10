class AwsHelper



  def initialize bucket_name
    @bucket_name = bucket_name
    @bucket
    @bucket_objects
    @images_on_aws
  end

  def images_on_aws
    @images_on_aws ||= bucket_objects.keys
  end

  def get_image_from_aws image_name
    if images_on_aws.include? image_name
      begin
        bucket_objects[image_name]
      rescue

      end
    else
      NullObject.new
    end
  end

  def get_images_from_aws image_name_arr
    image_name_arr.map! do |name|
      image = get_image_from_aws name
    end
    image_name_arr.select! do |image|
      image.class != NullObject
    end
    image_name_arr.map! do |image|
      other_image = OtherImage.new
      other_image.image = image
      other_image
    end
    image_name_arr
  end


  def bucket
    if @bucket.nil?
      begin
        @bucket = AWS::S3.new().buckets[@bucket_name]
      rescue
        @bucket = NullBucket.new

      end
    end
    @bucket
  end

  def bucket_objects
    if @bucket_objects.nil?
      @bucket_objects = {}
      begin
        bucket.objects.each do |obj|

          image_name = obj.key.split('/').last
          image_url = obj.public_url.to_s
          @bucket_objects[image_name] = image_url

        end
      rescue

      end
    end
    @bucket_objects
  end

end
