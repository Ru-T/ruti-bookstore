Rails.application.routes.draw do
  root 'books#index'
  resources :books, only: [:index, :show]
  devise_for :users, controllers: { registrations: "registrations" }
end
