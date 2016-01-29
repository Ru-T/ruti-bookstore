Rails.application.routes.draw do
  root 'books#index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :books, only: [:index, :show]
  devise_for :users, controllers: { registrations: "registrations" }
  resources :pending_purchases, except: [:new]
  resources :charges, only: [:new, :create]
end
