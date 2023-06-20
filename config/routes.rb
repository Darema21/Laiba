Rails.application.routes.draw do
  # [...]
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :events do
        member do
          post :booking
        end
      end
      resources :users, only: [:show]
      resources :bookings, only: [:index, :create, :destroy, :show]

      post 'login', to: 'sessions#login', as: :login
    end
  end
end
