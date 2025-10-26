ENV["RAILS_ENV"] ||= "test"

require File.expand_path("../config/environment", __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?

require "rspec/rails"
require 'shoulda/matchers'
require 'committee/rails'

# Dir[Rails.root.join("spec/support/**/*.rb")].sort.each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  # FactoryBotを使用するのでコメントアウト
  # config.fixture_path = Rails.root.join("spec/fixtures").to_s

  # If using ActiveRecord, run each example within a transaction
  config.use_transactional_fixtures = true

  # Infer test types from file locations (e.g., request specs)
  config.infer_spec_type_from_file_location!

  # Filter backtraces for cleaner output
  config.filter_rails_from_backtrace!

  # create(:account) などメソッドが使えるようになる
  config.include FactoryBot::Syntax::Methods

  # Committee (OpenAPI schema validation)
  config.include Committee::Rails::Test::Methods, type: :request
  config.add_setting :committee_options
  config.committee_options = {
    schema_path: Rails.root.join('public', 'doc', 'swagger.yml').to_s,
    parse_response_by_content_type: true,
    validate_success_only: false,
    strict_reference_validation: true
  }
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
