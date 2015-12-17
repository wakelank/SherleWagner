module RecentlyViewedProductsHelper

  def recently_viewed_products
    recently_viewed_products = []
    if cookies[:recently_viewed_products] && cookies[:recently_viewed_products].length > 2
      recently_viewed_products = JSON.parse(cookies[:recently_viewed_products])
    end
    recently_viewed_products
  end
end
