require 'rails_helper'

RSpec.describe IClass, type: :model do
  let(:iclass_attribs) { attributes_for(:i_class) }
  self::MODEL_ATTRIBUTES = %w[
    name
    year
    description
  ] # attachment and description optional

  describe 'is valid' do
    let(:iclass_attribs) { attributes_for(:i_class) }

    it 'with valid attributes' do
      expect(IClass.new(iclass_attribs)).to be_valid
    end
  end

  describe 'is not valid' do
    context 'without a value' do
      self::MODEL_ATTRIBUTES.each do |attribute|
        it "for a required attribute #{attribute}" do
          iclass = IClass.new(iclass_attribs.merge("#{attribute}": nil))
          expect(iclass).not_to be_valid
        end
      end
    end

    context 'if an IClass with the same name' do
      let(:institution) { create(:institution) }
      let(:i_class) { build(:i_class, institution: institution) }

      it 'exists in the same institution' do
        i_class.save!

        expect {
          IClass.create(name: i_class.name, institution: institution, year: i_class.year)
        }.not_to change { IClass.count }

        expect {
          IClass.create!(name: i_class.name, institution: institution, year: i_class.year)
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'scope' do
    let(:institution) { create(:institution) }
    let(:classes) { FactoryBot.create_list(:i_class, 5, institution: institution) }

    it 'returns correct values for for' do
      expect(IClass.for(institution)).to match_array classes
    end
  end
end
