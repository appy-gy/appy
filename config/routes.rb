Rails.application.routes.draw do
  namespace :api do
    namespace :private do
      resource  :sessions, only: [:show, :create, :destroy]
      resources :sections, only: [:index]
      resources :users, module: :users, only: [:show, :create, :update] do
        resources :ratings, only: [:index]
      end
      resources :ratings, module: :ratings, only: [:index, :show, :update] do
        resource :tags, only: [:create, :destroy]
        resources :rating_items, only: [:index, :create, :update]
        resources :comments, only: [:index, :create]
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
