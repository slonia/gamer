Rails.application.routes.draw do
  devise_for :users
  resources :teams, only: [:index, :show]

  root 'teams#index'

  namespace :admin do
    devise_for :users

    resources :teams do
      resources :users
    end
  end
end
