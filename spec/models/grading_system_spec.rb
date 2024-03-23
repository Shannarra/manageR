require 'rails_helper'

RSpec.describe GradingSystem, type: :model do
  let(:grading_system_attribs) { attributes_for(:grading_system) }
  self::MODEL_ATTRIBUTES = %w[
    direction
    name
    institution_id
  ] # attachment and description optional

  describe 'is valid' do
    it 'with valid attributes' do
      expect(GradingSystem.new(grading_system_attribs)).to be_valid
    end
  end

  describe 'is not valid' do
    context 'without a value' do
      self::MODEL_ATTRIBUTES.each do |attribute|
        it "for a required attribute #{attribute}" do
          grading_system = GradingSystem.new(grading_system_attribs.merge("#{attribute}": nil))
          expect(grading_system).not_to be_valid
        end
      end
    end
  end
end
