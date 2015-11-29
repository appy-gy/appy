Rails.application.routes.draw do
  ActiveAdmin.routes self

  namespace :api do
    namespace :private do
      resource :sessions, only: [:create, :destroy]
      resource :reset_passwords, only: [:create]
      resources :users, only: [:create]
      resources :ratings, only: [:create, :update, :destroy] do
        scope module: :ratings do
          resource :tags, only: [:create, :destroy]
          resources :rating_items, only: [:create, :update, :destroy] do
            put :positions, on: :collection
          end
          resources :comments, only: [:create]
        end
      end
      resources :rating_items, only: [] do
        scope module: :rating_items do
          resources :votes, only: [:create]
        end
      end
    end
  end

  resource :oauth, only: [] do
    get :callback
    post :callback
    get ':provider', action: :oauth
  end
end
