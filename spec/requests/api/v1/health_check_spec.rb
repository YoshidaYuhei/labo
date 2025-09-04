require "rails_helper"

RSpec.describe "HealthCheck", type: :request do
  describe "GET /api/v1/health_check" do
    it "returns ok status JSON" do
      get "/api/v1/health_check"
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json).to include("status" => "ok")
    end
  end
end
