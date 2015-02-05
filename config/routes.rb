Rails.application.routes.draw do
  root 'home#index'

  namespace :api do
    namespace :private do
      resources :users, only: [:create, :update]
      resources :user_sessions, only: [:create, :destroy]
      resources :ratings, only: [:index]
    end
  end
end
