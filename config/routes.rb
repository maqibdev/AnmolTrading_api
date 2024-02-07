Rails.application.routes.draw do
  namespace :api do
    resources :cars, only: [:index, :show, :create, :update, :destroy]
  end
end
