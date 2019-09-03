Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :thermostats, only: [] do
        resources :readings, param: :tracking_number, only: [:show, :create]
        resource :stats, only: :show
      end
    end
  end
end
