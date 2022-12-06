Rails.application.routes.draw do
  # match "/404", to: "errors#not_found", via: :all
  # match "/500", to: "errors#internal_server_error", via: :all

  # get 'errors/not_found'
  # get 'errors/internal_server_error'
  root to: "welcome#index"

  devise_for :admin_users, ActiveAdmin::Devise.config
  # devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: { sessions: 'users/sessions' }

  get 'carts/add_to_cart'
  post 'carts/remove_from_cart'
  post 'carts/update_cart'

  resources :sales_order_details
  resources :sales_orders
  resources :addresses
  resources :categories
  resources :products
  resources :static_pages
  resources :carts, path: :cart
end
