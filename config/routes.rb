Rails.application.routes.draw do
  devise_for :users
  root 'users#index'

  resources :teams, only: [:index, :show]

  namespace :admin do
    devise_for :users

    resources :teams do
      resources :users
    end
  end
end
