require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'is valid' do
    let(:user_attribs) { attributes_for(:user) }

    it 'with valid attributes' do
      expect(User.new(user_attribs)).to be_valid
    end
  end

  describe 'is not valid' do
    it 'without an email' do
      user = User.new(email: nil)
      expect(user).not_to be_valid
    end
    
    it 'without an encrypted_password' do
      user = User.new(encrypted_password: nil)
      expect(user).not_to be_valid
    end

    it 'without an institution_id' do
      user = User.new(institution_id: nil)
      expect(user).not_to be_valid
    end    
  end
end
