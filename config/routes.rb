SimpleStore::Application.routes.draw do
  get "orders/index"
  get "orders/new/:address_id" => "orders#new", as: :new_order
  get "orders/show"
  get "addresses/add_address" => "addresses#add_address", as: :add_address
  post "addresses/add_address_create" => "addresses#add_address_create", as: :add_address_create
  delete "addresses/add_address_delete" => "addresses#add_address_delete", as: :add_address_delete
  get "addresses/add_address_edit" => "addresses#add_address_edit", as: :add_address_edit
  patch "addresses/add_address_update/:address_id" => "addresses#add_address_update", as: :add_address_update

  resources :addresses

  devise_for :users
  resources :categories
  resources :products

  root 'storefront#index'
  
  post "storefront/add_cart"
  delete "storefront/remove_cart_item"


  get "products-by-category/:category_id" => "storefront#index", as: :products_by_category
  get "choose_address/:user_id" => "addresses#choose_address", as: :choose_address

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
