module Api
  module V1
    module Accounts
      class RegistrationsController < Devise::RegistrationsController
        respond_to :json
        skip_before_action :verify_authenticity_token # APIならCSRFは無効化が一般的

        # POST /api/v1/accounts
        # params { account: { email, password, password_confirmation } }
        def create
          build_resource(sign_up_params)

          if resource.save && resource.active_for_authentication?
            sign_up(resource_name, resource) # warden により JWT が Authorization ヘッダで発行される
            render json: { status: 'ok', message: 'Account created successfully' }, status: :created
          else
            render json: { status: 'error', message: 'Account creation failed' }, status: :bad_request
          end
        end

        private

        def sign_up_params
          params.require(:account).permit(:email, :password, :password_confirmation)
        end
      end
    end
  end
end
