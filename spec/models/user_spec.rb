require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user_attribs) { attributes_for(:user) }
  self::MODEL_ATTRIBUTES = %w[access_type email]

  describe 'is valid' do
    it 'with valid attributes' do
      expect(User.new(user_attribs)).to be_valid
    end
  end

  describe 'is not valid' do
    context 'without a value' do
      self::MODEL_ATTRIBUTES.each do |attribute|
        it "for a required attribute #{attribute}" do
          user = User.new(user_attribs.merge("#{attribute}": nil))
          expect(user).not_to be_valid
        end
      end
    end
  end
end
