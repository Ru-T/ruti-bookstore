Rails.application.routes.draw do
  root 'books#index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :books, only: [:index]
  resources :pending_purchases, except: [:new]
  devise_for :users, controllers: { registrations: "registrations" }
end
