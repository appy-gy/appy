Rails.application.routes.draw do
  ActiveAdmin.routes self

  namespace :api do
    namespace :private do
      resource :sessions, only: [:show, :create, :destroy] do
        get :check, on: :collection
      end
      resource :reset_passwords, only: [:create]
      resources :sections, only: [] do
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
        get :video_info, on: :collection
        scope module: :rating_items do
          resources :votes, only: [:create]
        end
      end
      resources :tags, only: [:index, :show] do
        get :popular, on: :collection
        scope module: :tags do
          resources :ratings, only: [:index]
        end
      end
      resources :pages, only: [:show] do
        get :footer, on: :collection
      end
      resource :search, only: [] do
        get :global, on: :collection
      end
    end
  end

  resource :oauth, only: [] do
    get :callback
    post :callback
    get ':provider', action: :oauth
  end
end
