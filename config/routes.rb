Rails.application.routes.draw do
  devise_for :users
  resources :teams, only: [:index, :show]
  match '/game_visits/:game_id/:user_id', to: 'game_visits#set', via: :get

  root 'teams#index'

  namespace :admin do
    devise_for :users

    resources :teams do
      resources :users
    end
  end
end
