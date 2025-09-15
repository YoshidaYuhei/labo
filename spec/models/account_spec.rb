require 'rails_helper'

RSpec.describe Account, type: :model do
  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:account)).to be_valid
    end
  end

  describe 'devise' do
    it 'is valid with valid attributes' do
      expect(build(:account)).to be_valid
    end
    it '正しい/誤ったパスワードで valid_password? が true/false を返す' do
      account = create(:account, password: 'password123', password_confirmation: 'password123')
      expect(account.valid_password?('password123')).to be true
      expect(account.valid_password?('WRONG')).to be false
    end
  end
end
