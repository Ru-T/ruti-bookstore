Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'books#index'
  resources :books, only: [:index]
  resources :pending_purchases, only: [:index, :create]
  devise_for :users, controllers: { registrations: "registrations" }
end
