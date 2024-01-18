Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }

  root "categories#index"

  resources :categories
  resources :transactions
  
  resources :users
end
