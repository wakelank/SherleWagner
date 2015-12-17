module RecentlyViewedProductsHelper

  def recently_viewed_products
    if there_are_recently_viewed_products?
      recently_viewed_products = JSON.parse(cookies[:recently_viewed_products])
      recently_viewed_products.map do |recently_viewed_product|
        Product.find_by(id: recently_viewed_product["product_id"])
      end
    end
  end

  def there_are_recently_viewed_products?
    cookies[:recently_viewed_products] && cookies[:recently_viewed_products].length > 2
  end

end
