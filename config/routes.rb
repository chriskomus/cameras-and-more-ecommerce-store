Rails.application.routes.draw do
  root to: "welcome#index"


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :sales_order_details
  resources :sales_orders
  resources :addresses
  resources :categories
  resources :products
  resources :static_pages
end
