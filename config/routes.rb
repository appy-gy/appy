Rails.application.routes.draw do
  root 'home#index'

  namespace :api do
    namespace :private do
      resources :users, only: [:create, :update]
    end
  end
end
