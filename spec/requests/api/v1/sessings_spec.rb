require 'swagger_helper'

RSpec.describe 'Accounts::Sessions', type: :request do
  path '/api/v1/accounts/sign_in' do
    post 'ログイン' do
      tags 'Auth'
      consumes 'application/json'
      produces 'application/json'
      security [] # ログインは認証不要

      parameter name: :account, in: :body, required: true, schema: {
        type: :object,
        required: [ 'account' ],
        properties: {
          account: { 
            type: :object,
            required: [ 'email', 'password' ],
            properties: {
              email: { type: :string, format: :email },
              password: { type: :string, minLength: 6 }
            }
          }
        }
      }

      response '200', 'OK' do
        let(:account) do
          {
            account: { email: 'test@example.com', password: 'password123' }
          }
        end

        before do
          create(:account, email: 'test@example.com', password: 'password123')
        end

        schema type: :object,
               required: [ 'status' ],
               properties: {
                 status: { type: :string, enum: [ 'ok' ] }
               }
        it 'ログインできる' do |example|
          submit_request(example.metadata)
          expect(response.status).to eq(200)
          expect(response.body).to include('ok')
          expect(response.headers['Authorization']).to include('Bearer')
        end
      end

      response '401', 'Unauthorized' do
        let(:account) do
          { account: { email: 'test@example.com', password: 'WRONG' } }
        end
        schema type: :object,
               required: [ 'status' ],
               properties: { status: { type: :string, enum: [ 'error' ] } }
        it 'ログインできない' do |example|
          submit_request(example.metadata)
          expect(response.status).to eq(401)
          expect(response.body).to include('error')
        end
      end
    end
  end
end