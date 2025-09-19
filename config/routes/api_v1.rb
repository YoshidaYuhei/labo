Rails.application.routes.draw do
  namespace :api, defaults: { format: :json }do
    namespace :v1 do
      resources :health_check, only: [ :index ]
      devise_for :accounts,
        path: 'accounts',
        controllers: {
          registrations: 'api/v1/accounts/registrations'
        }
    end
  end
end
