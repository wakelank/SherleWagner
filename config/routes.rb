Rails.application.routes.draw do
  
  
  
  get 'showrooms' => 'showrooms#index'
  

  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'product_configurations/show'
  get 'edit_homepage' => 'static_pages#edit_homepage'
  get 'update_homepage' => 'static_pages#update_homepage'
  post 'update_homepage_preview' => 'static_pages#update_homepage_preview'
  get 'homepage_preview' => 'static_pages#home_preview'
  get 'mail_tester' => 'static_pages#mail_tester'


  get 'style/show'

  get 'product_sub_types/show'

  get 'products/upload_page' => 'static_pages#upload_page'
  post 'products/upload_products' => 'products#upload_product_file'
 
  get 'products/tearsheet/:product_id/:tearsheet_number' => 'products#tearsheet'

  get 'catalog' => 'static_pages#catalog'
  get 'contact' => 'static_pages#contact'
  get 'contact/:file' => 'static_pages#contact'


  # get 'showrooms' => 'static_pages#showrooms'
  get 'history' => 'static_pages#history'
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
  post "inquiry" => 'favorites#create_inquiry'
  resources :favorites, only: [:index, :create, :destroy]
  post 'send_contact_with_favorites' => 'favorites#send_contact_with_favorites'
  #resources :compilations, only: [:show]
  resources :styles, only: [:index, :show]
  resources :genres, only: [:index, :show]
  resources :product_configurations, only: [:show]

  get "/fetch_items" => 'products#from_category', as: 'fetch_items'
  get "/fetch_cat" => 'product_types#an_category', as: 'fetch_cat'
  post "/product_types" => 'product_types#index'


  # =====keep this at bottom of routes for error routing ======
  get "*any", via: :all, to: "errors#not_found"
  # =====keep this at bottom ======

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
