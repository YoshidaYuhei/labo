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
require 'rails_helper'

RSpec.describe JwtDenylist, type: :model do
  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:jwt_denylist)).to be_valid
    end
  end
end
