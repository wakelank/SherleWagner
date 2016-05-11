class NullImage
  def url(*args)
    Rails.root.join('public/images/medium/missing_product.jpg').to_s
  end
end
