require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  describe 'is valid' do
    let(:admin_user_attribs) { attributes_for(:admin_user) }

    it 'with valid attributes' do
      expect(AdminUser.new(admin_user_attribs)).to be_valid
    end
  end

  describe 'is not valid' do
    it 'without an email' do
      user = AdminUser.new(email: nil)
      expect(user).not_to be_valid
    end
    
    it 'without an encrypted_password' do
      user = AdminUser.new(encrypted_password: nil)
      expect(user).not_to be_valid
    end
  end
end
