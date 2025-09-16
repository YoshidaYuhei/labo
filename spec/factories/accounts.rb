FactoryBot.define do
  factory :account do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }

    confirmed_at { Time.zone.now }
  end
end
