# == Schema Information
#
# Table name: accounts(アカウント)
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(191)
#  confirmed_at           :datetime
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string(255)
#  email                  :string(191)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  failed_attempts        :integer          default(0), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string(255)
#  locked_at              :datetime
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(191)
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string(191)
#  unlock_token           :string(191)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_accounts_on_confirmation_token    (confirmation_token) UNIQUE
#  index_accounts_on_email                 (email) UNIQUE
#  index_accounts_on_reset_password_token  (reset_password_token) UNIQUE
#  index_accounts_on_unlock_token          (unlock_token) UNIQUE
#
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
