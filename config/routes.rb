Rails.application.routes.draw do
  get 'dashboard/index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations' }
  match '/users/:provider/weekly_toggle', to: "users#weekly_toggle", via: :get, as: :weekly_toggle
  resources :teams, param: :slug do
    get :visits, on: :member
    resources :team_requests
  end
  resource :dashboard, only: [:index]
  resources :games
  match '/teams/:slug/user/:id/accept', to: 'team_requests#accept', via: :get, as: :accept_team_request
  match '/teams/:slug/user/:id/reject', to: 'team_requests#reject', via: :get, as: :reject_team_request
  match '/game_visits/:game_id', to: 'game_visits#set', via: :get
  match '/profile', to: 'users#show', via: :get, as: :profile

  root 'dashboard#index'

  namespace :admin do

    resources :teams do
      resources :users
    end
  end
end
