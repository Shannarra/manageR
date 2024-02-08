require 'rails_helper'

RSpec.describe IClass, type: :model do
  describe 'is valid' do
    let(:iclass_attribs) { attributes_for(:i_class) }

    it 'with valid attributes' do
      expect(IClass.new(iclass_attribs)).to be_valid
    end
  end

  describe 'is not valid' do
    it 'without institution id' do
      iclass = IClass.new(institution_id: nil)
      expect(iclass).not_to be_valid
    end
  end
end
