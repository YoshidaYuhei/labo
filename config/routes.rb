Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  devise_for :accounts,
    path: 'api/v1/accounts',
    controllers: {
      registrations: 'api/v1/accounts/registrations',
      sessions: 'api/v1/accounts/sessions'
    }
  draw :api_v1
end
