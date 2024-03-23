require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  let(:admin_user_attribs) { attributes_for(:admin_user) }
  self::MODEL_ATTRIBUTES = %w[email encrypted_password]

  describe 'is valid' do
    it 'with valid attributes' do
      expect(AdminUser.new(admin_user_attribs)).to be_valid
    end
  end

  describe 'is not valid' do
    context 'without a value' do
      self::MODEL_ATTRIBUTES.each do |attribute|
        it "for a required attribute #{attribute}" do
          user = AdminUser.new(admin_user_attribs.merge("#{attribute}": nil))
          expect(user).not_to be_valid
        end
      end
    end
  end
end
