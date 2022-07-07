Rails.application.routes.draw do
  namespace :admin do
      resources :groups
      resources :users

      root to: "groups#index"
    end
  devise_for :users
  resources :groups
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
end
