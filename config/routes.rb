Rails.application.routes.draw do
  root 'home#index'

  namespace :api do
    namespace :private do
      resource  :sessions, only: [:show, :create, :destroy]
      resources :sections, only: [:index]
      resources :users, only: [:create, :update]
      resources :ratings, only: [:index, :show]
      resources :header_sections, only: [:index]
    end
  end

  resource :oauth, only: [] do
    get :callback
    post :callback
    get ':provider', to: :oauth
  end

  get '*path', to: 'home#index'
end
