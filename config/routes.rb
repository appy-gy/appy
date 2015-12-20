Rails.application.routes.draw do
  ActiveAdmin.routes self

  namespace :api do
    namespace :private do
      resource :sessions, only: [:create, :destroy]
      resource :reset_passwords, only: [:create]
      resources :users, only: [:create]
      resources :ratings, only: [:create, :update, :destroy]
    end
  end

  resource :oauth, only: [] do
    get :callback
    post :callback
    get ':provider', action: :oauth
  end
end
