Rails.application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :appointments
      resources :users
      get "psychologists/:id/available_appointments", to: "psychologists#available_appointments"
    end
  end
end
