Rails.application.routes.draw do
  root 'home#index'

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :update]

      post '/login', to: 'user_sessions#new', as: :login
      delete '/logout', to:'user_sessions#destroy', as: :logout
    end
  end
  
end
