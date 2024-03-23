require 'rails_helper'

RSpec.describe Institution, type: :model do
  let(:institution_attribs) { attributes_for(:institution) }
  self::MODEL_ATTRIBUTES = %w[
    name
    location
    code
  ] # attachment and description optional

  describe 'is valid' do
    let(:institution_attribs) { attributes_for(:institution) }

    it 'with valid attributes' do
      expect(Institution.new(institution_attribs)).to be_valid
    end
  end

  describe 'is not valid' do
    context 'without a value' do
      self::MODEL_ATTRIBUTES.each do |attribute|
        it "for a required attribute #{attribute}" do
          institution = Institution.new(institution_attribs.merge("#{attribute}": nil))
          expect(institution).not_to be_valid
        end
      end
    end
  end
end
