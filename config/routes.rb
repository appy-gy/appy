Rails.application.routes.draw do
  root 'home#index'

  namespace :api do
    namespace :private do
      resource  :sessions, only: [:show, :create, :destroy]
      resources :sections, only: [:index]
      resources :users, only: [:create, :update]
      resources :ratings, only: [:index, :show, :update]
      resources :header_sections, only: [:index]
    end
  end

  get '*path', to: 'home#index'
end
