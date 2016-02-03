Rails.application.routes.draw do
  root 'books#index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :books, only: [:index, :show]
  devise_for :users, controllers: { registrations: "registrations" }
  resources :cart, only: [:show]
  resources :line_items
end
