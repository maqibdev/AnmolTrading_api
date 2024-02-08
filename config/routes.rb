Rails.application.routes.draw do
  namespace :api do
    resources :cars, only: %i[index show create update destroy]

    devise_for :users,
               path: '',
               path_names: {
                 sign_in: 'login',
                 sign_out: 'logout',
                 registration: 'signup'
               },
               controllers: {
                 sessions: 'api/sessions',
                 registrations: 'api/registrations'
               }
  end
end
