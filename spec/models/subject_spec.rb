require 'rails_helper'

RSpec.describe Subject, type: :model do
  let(:subject_attribs) { attributes_for(:subject) }
  self::MODEL_ATTRIBUTES = %w[
    name
    year
    description
  ] # attachment and description optional

  describe 'is valid' do
    let(:subject_attribs) { attributes_for(:subject) }

    it 'with valid attributes' do
      expect(Subject.new(subject_attribs)).to be_valid
    end
  end

  describe 'is not valid' do
    context 'without a value' do
      self::MODEL_ATTRIBUTES.each do |attribute|
        it "for a required attribute #{attribute}" do
          subject = Subject.new(subject_attribs.merge("#{attribute}": nil))
          expect(subject).not_to be_valid
        end
      end
    end
  end
end
