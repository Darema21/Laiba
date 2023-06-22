Rails.application.routes.draw do
  # [...]
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :events do
        member do
          post :booking, to: 'bookings#create'
        end
      end
      resources :users, only: [:show]
      resources :bookings, only: [:create, :destroy]
    end
  end
end
