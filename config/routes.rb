Rails.application.routes.draw do

  get "/auth/facebook", as: :sign_in_with_facebook
  get "/auth/facebook/callback" => "callbacks#facebook"

  get "/auth/twitter", as: :sign_in_with_twitter
  get "/auth/twitter/callback" => "callbacks#twitter"

  resources :entries
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  match "/delayed_job" => DelayedJobWeb, :anchor => false, via: [:get, :post]

  root "home#index"
  get "/about" => "home#about"

  resources :users, only: [:new, :create, :edit, :update, :destroy]

  resources :contests  do
    patch "publish" => "contests#publish", as: :publish
    resources :entries, only: [:create, :update, :destroy]
    get "new_featured" => "contests#new_featured", as: :new_featured, on: :collection
  end

  get "/users/new_customer" => "users#new_customer", as: :new_customer
  get "/users/edit_customer" => "users#edit_customer", as: :edit_customer
  # delete "/users/edit_customer" => "users#edit_customer", as: :delete_customer

  scope module: 'users' do
    resources :password_resets, only: [:new, :create, :edit, :update]
    resources :password_changes, only: [:edit, :update]
    resources :account_verifications, only: [:new, :create, :edit]
  end

  get "/customer/contests" => "customer#contests", as: :customer_contests

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :messages


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
