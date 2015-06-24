Rails.application.routes.draw do
  namespace :api do
    namespace :private do
      resource  :sessions, only: [:show, :create, :destroy]
      resources :sections, module: :sections, only: [:index, :show] do
        resources :ratings, only: [:index]
      end
      resources :users, module: :users, only: [:show, :create, :update] do
        resources :ratings, only: [:index]
        resources :comments, only: [:index]
      end
      resources :ratings, module: :ratings, only: [:index, :show, :create, :update, :destroy] do
        resource :tags, only: [:create, :destroy]
        resources :rating_items, only: [:index, :create, :update, :destroy] do
          put :positions, on: :collection
        end
        resources :comments, only: [:index, :create]
        resources :likes, only: [:create] do
          delete :destroy, on: :collection
        end
      end
      resources :rating_items, module: :rating_items, only: [] do
        resources :votes, only: [:create]
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
