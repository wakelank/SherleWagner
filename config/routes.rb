Rails.application.routes.draw do
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'product_configurations/show'


  get 'style/show'

  get 'product_sub_types/show'

  get 'products/upload_page' => 'static_pages#upload_page'
  post 'products/upload_products' => 'products#upload_product_file'
  post 'products/tearsheet' => 'products#build_tearsheet'
  get 'products/tearsheet' => 'products#show'

#  get 'product_groups/add_favorite' => 'product_groups#add_favorite'


  root 'static_pages#home'
  resources :products
  #resources :product_groups

 # get 'product_types/:product_type' => 'product_groups#index'
  

#  resources :product_groups, :defaults => { :format => 'html' }

  resources :product_types, except:[:create] do
    resources :product_sub_types
  end
  
  get 'search'=>'search#index'

  get 'login' => 'sessions#new'
  post 'sessions' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  resources :tearsheets, only: [:show, :create]
  resources :favorites, only: [:index, :create, :destroy]
  #resources :compilations, only: [:show]
  resources :styles, only: [:index, :show]
  resources :genres, only: [:index, :show]
  resources :product_configurations, only: [:show]

  get "/fetch_items" => 'products#from_category', as: 'fetch_items'
  get "/fetch_cat" => 'product_types#an_category', as: 'fetch_cat'
  post "/product_types" => 'product_types#index'

  #post 'static_pages/upload_file' => 'static_pages#upload_products'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
