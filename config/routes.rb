Rails.application.routes.draw do
  root 'books#index'
  resources :books, only: [:index]
  devise_for :users, controllers: { registrations: "registrations" }
end
