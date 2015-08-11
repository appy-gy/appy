Rails.application.routes.draw do
  ActiveAdmin.routes self

  namespace :api do
    namespace :private do
      resource :sessions, only: [:show, :create, :destroy]
      resource :reset_passwords, only: [:create]
      resources :sections, only: [:index, :show] do
        scope module: :sections do
          resources :ratings, only: [:index]
        end
      end
      resources :users, only: [:show, :create, :update] do
        put :change_password
        scope module: :users do
          resources :ratings, only: [:index]
          resources :comments, only: [:index]
        end
      end
      resources :ratings, only: [:index, :show, :create, :update, :destroy] do
        scope module: :ratings do
          resource :tags, only: [:create, :destroy]
          resources :rating_items, only: [:index, :create, :update, :destroy] do
            put :positions, on: :collection
          end
          resources :comments, only: [:index, :create]
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
      resources :header_sections, only: [:index]
      resources :tags, only: [:index]
    end
  end

  resource :oauth, only: [] do
    get :callback
    post :callback
    get ':provider', action: :oauth
  end
end
