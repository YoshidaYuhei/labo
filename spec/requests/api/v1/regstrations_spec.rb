require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'Accounts::Regstrations', type: :request do
  path '/api/v1/accounts' do
    post 'アカウント登録' do
      tags 'Auth'
      consumes 'application/json'
      produces 'application/json'
      security [] # サインアップは認証不要

      parameter name: :account, in: :body, required: true, schema: {
        type: :object,
        required: [ 'account' ],
        properties: {
          account: {
            type: :object,
            required: [ 'email', 'password', 'password_confirmation' ],
            properties: {
              email: { type: :string, format: :email },
              password: { type: :string, minLength: 6 },
              password_confirmation: { type: :string, minLength: 6 }
            }
          }
        }
      }

      response '201', 'OK' do
        let(:account) do
          {
            account: {
              email: 'test@example.com',
              password: 'password123',
              password_confirmation: 'password123'
            }
          }
        end
        schema type: :object,
               required: [ 'status' ],
               properties: {
                 status: { type: :string, enum: [ 'ok' ] }
               }
        
        it 'アカウントを作成し、JWTを発行する' do |example|
          expect {
            submit_request(example.metadata)
          }.to change(Account, :count).by(1)

          expect(response.status).to eq(201)
          expect(response.body).to include('ok')
          expect(response.headers['Authorization']).to include('Bearer')
        end
      end

      context 'バリデーションエラー' do
        response '400', 'Bad Request' do
          let(:account) do
            {
              account: { email: 'test@example.com' }
            }
          end
          schema type: :object,
                 required: [ 'status' ],
                 properties: {
                   status: { type: :string, enum: [ 'error' ] }
                 }
          it 'アカウントを作成できない' do |example|
            expect {
              submit_request(example.metadata)
            }.not_to change(Account, :count)

            expect(response.status).to eq(400)
            expect(response.body).to include('error')
          end
        end
      end
    end
  end
end
