Rails.application.routes.draw do
  # [...]
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :events
      resources :users, only: [:show]
      resources :bookings, only: [:create, :destroy]
    end
  end
end
