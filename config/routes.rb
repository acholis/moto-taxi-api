Rails.application.routes.draw do

    namespace :api, defaults: { format: :json }  do
        namespace :v1 do
            resources :customers, only: [:update]
        end
    end
        
    devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
    }



end
