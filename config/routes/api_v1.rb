Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      devise_for :accounts
      resources :health_check, only: [ :index ]
    end
  end
end
