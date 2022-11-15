Rails.application.routes.draw do
  root to: "welcome#index"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :sales_order_details
  resources :sales_orders
  resources :addresses
  resources :categories
  resources :products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  #

  get '/about', to: 'welcome#about', as: :about
end
