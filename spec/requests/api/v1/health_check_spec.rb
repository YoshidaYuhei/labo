require "rails_helper"

RSpec.describe 'API V1 HealthCheck', type: :request do
  describe 'GET /api/v1/health_check' do
    it 'ヘルスチェックが成功する' do
      get '/api/v1/health_check'

      expect(response).to have_http_status(:ok)
      expect(response.content_type).to match(/application\/json/)

      expect(response.parsed_body['status']).to eq('ok')

      # OpenAPI schema validation
      assert_response_schema_confirm(200)
    end
  end
end
