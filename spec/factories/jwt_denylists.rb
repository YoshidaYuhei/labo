# == Schema Information
#
# Table name: jwt_denylists(JWT無効化リスト)
#
#  id            :bigint           not null, primary key
#  exp(有効期限) :datetime         not null
#  jti(JWT ID)   :string(255)      not null
#
# Indexes
#
#  index_jwt_denylists_on_jti  (jti)
#
FactoryBot.define do
  factory :jwt_denylist do
    jti { Faker::Alphanumeric.alphanumeric(number: 10) }
    exp { Time.zone.now + 30.minutes }
  end
end
