Rails.application.routes.draw do
  ActiveAdmin.routes self

  namespace :api do
    namespace :private do
      resource :sessions, only: [:show, :create, :destroy] do
        get :check, on: :collection
      end
      resource :reset_passwords, only: [:create]
      resources :users, only: [:create, :update] do
        put :change_password
      end
      resources :ratings, only: [:create, :update, :destroy] do
        put :view
        scope module: :ratings do
          resource :tags, only: [:create, :destroy]
          resources :rating_items, only: [:create, :update, :destroy] do
            put :positions, on: :collection
          end
          resources :comments, only: [:create]
          resources :likes, only: [:create] do
            delete :destroy, on: :collection
          end
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
