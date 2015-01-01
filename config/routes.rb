Rails.application.routes.draw do
  get 'dashboard/index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  resources :teams, param: :slug, only: [:index, :show]
  resource :dashboard, only: [:index]
  match '/game_visits/:game_id', to: 'game_visits#set', via: :get
  match '/profile', to: 'users#show', via: :get

  root 'dashboard#index'

  namespace :admin do

    resources :teams do
      resources :users
    end
  end
end
