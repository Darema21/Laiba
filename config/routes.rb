Rails.application.routes.draw do
  # [...]
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'login', to: 'sessions#login', as: :login

      resources :events do
        member do
          post :booking, to: 'bookings#create'
          post :upload_image
        end
        collection do
          get :category, to: 'events#category'
        end
      end
      resources :users, only: [:show] do
        collection do
          get :promoters
        end
      end
    end
  end
end
