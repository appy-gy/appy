Rails.application.routes.draw do
  ActiveAdmin.routes self

  namespace :api do
    namespace :private do
      resources :browser_notifications, only: [:index] do
        put :click
      end
      resource :browser_notification_subscriptions, only: [:update]
      resource :sessions, only: [:show, :create, :destroy] do
        get :check, on: :collection
      end
      resource :reset_passwords, only: [:create, :update]
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
        get :similar, :prev_next
        put :view
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
      resource :main_page_ratings, only: [:show]
      resources :rating_items, only: [] do
        get :video_info, on: :collection
        scope module: :rating_items do
          resources :votes, only: [:create]
        end
      end
      resources :header_sections, only: [:index, :show]
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
      resources :client_errors, only: [:create]
    end
  end

  resource :oauth, only: [] do
    get :callback
    post :callback
    get ':provider', action: :oauth
  end
end
