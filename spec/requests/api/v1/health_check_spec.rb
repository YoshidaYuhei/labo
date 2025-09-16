require "rails_helper"
require 'swagger_helper'

RSpec.describe 'HealthCheck', type: :request do
  path '/api/v1/health_check' do
    get 'ヘルスチェック' do
      tags 'Health'
      produces 'application/json'
      security []

      response '200', 'OK' do
        schema type: :object,
               required: ['status'],
               properties: {
                 status: { type: :string, enum: ['ok'] }
               }

        run_test!
      end
    end
  end
end
