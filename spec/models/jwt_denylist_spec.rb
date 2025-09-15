require 'rails_helper'

RSpec.describe JwtDenylist, type: :model do
  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:jwt_denylist)).to be_valid
    end
  end
end