Rails.application.routes.draw do
  get 'dashboard/index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }
  resources :teams, param: :slug do
    get :visits, on: :member
    resources :team_requests
  end
  resource :dashboard, only: [:index]
  resources :games
  match '/game_visits/:game_id', to: 'game_visits#set', via: :get
  match '/profile', to: 'users#show', via: :get

  root 'dashboard#index'

  namespace :admin do

    resources :teams do
      resources :users
    end
  end
end
