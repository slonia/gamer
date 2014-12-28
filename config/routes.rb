Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  resources :teams, only: [:index, :show]
  match '/game_visits/:game_id', to: 'game_visits#set', via: :get
  match '/profile', to: 'users#show', via: :get

  root 'teams#index'

  namespace :admin do

    resources :teams do
      resources :users
    end
  end
end
