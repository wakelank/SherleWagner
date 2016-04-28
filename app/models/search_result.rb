class SearchResult

  attr_reader :image, :url, :name

  def initialize(image: image, url: url, name: name)
    @image = image
    @url = url
    @name = name
  end
end
