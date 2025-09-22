module Api
  module V1
    module Accounts
      class SessionsController < Devise::SessionsController
        respond_to :json
        skip_before_action :verify_authenticity_token

        # POST /api/v1/accounts/sign_in
        def create
          self.resource = warden.authenticate(:database_authenticatable)
          if resource
            sign_in(resource_name, resource)
            render json: { status: 'ok', message: 'Login successful' }, status: :ok
          else
            render json: { status: 'error', message: 'Login failed' }, status: :unauthorized
          end
        end

        # DELETE /api/v1/accounts/sign_out
        def destroy
          warden.authenticate!(:jwt, scope: resource_name)
          sign_out(resource_name)
          head :no_content
        end

        private

        def create_params
          params.require(:account).permit(:email, :password)
        end
      end
    end
  end
end
