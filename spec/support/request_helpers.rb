# spec/support/request_helpers.rb
module RequestHelpers
  def json_headers
    { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
  end

  # devise-jwt 公式のテストヘルパ
  def auth_headers_for(account)
    require 'devise/jwt/test_helpers'
    Devise::JWT::TestHelpers.auth_headers(json_headers.dup, account)
  end
end

RSpec.configure { |c| c.include RequestHelpers }
