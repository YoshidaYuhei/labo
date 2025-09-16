FactoryBot.define do
  factory :jwt_denylist do
    jti { Faker::Alphanumeric.alphanumeric(number: 10) }
    exp { Time.zone.now + 30.minutes }
  end
end
