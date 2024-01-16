Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  resources :entities
  resources :groups
  resources :users

end
