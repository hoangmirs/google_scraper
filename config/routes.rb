require 'sidekiq/web'
Rails.application.routes.draw do
  use_doorkeeper
  mount Sidekiq::Web => '/sidekiq'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "search_results#new"

  resources :search_results, except: [:edit, :update, :create]
  resources :link_queries, only: :index

  namespace :api do
    namespace :v1 do
      resource :search, only: :create
      resources :link_queries, only: :index
      resources :search_results, only: [:index, :show]
    end
  end
end
