class Favorite

  attr_accessor :url, :tearsheet_number, :id, :product_id, :product_image, :product_name

  def initialize(args)
    @url = args[:url]
    @tearsheet_number = args[:tearsheet]
    @id = args[:id]
    @product_id = args[:product_id]
    @product_name = Product.find_by(id: @product_id).name || ""
    @product_number = Product.find_by(id: @product_id).number || ""

    @product_image = Product.find_by(id: @product_id).image.url || ""

  end

  def self.all(cookie)
    JSON.parse(cookie) if cookie
  end

  def self.find_by(args)
  end

  def css_id
    "favorite_#{@id}"
  end

  def url
    @url
  end

  def id
    @id || 0
  end

  def product_name
    @product_name
  end
  def tearsheet_number
    @tearsheet
  end

  def product_id
    @product_id
  end

  def last
  end

  def info_for_email
    "#{@product_name}: #{@product_number}"
  end

end

