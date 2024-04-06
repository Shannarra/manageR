require 'rails_helper'

RSpec.describe Report, type: :model do
  let(:report_attribs) { attributes_for(:report) }
  self::MODEL_ATTRIBUTES = %w[
    name
    institution_id
    by_id
    creation_scope
  ]

  describe 'is valid' do
    it 'with valid attributes' do
      expect(Report.new(report_attribs)).to be_valid
    end
  end

  describe 'is not valid' do
    context 'without a value' do
      self::MODEL_ATTRIBUTES.each do |attribute|
        it "for a required attribute #{attribute}" do
          report = Report.new(report_attribs.merge("#{attribute}": nil))
          expect(report).not_to be_valid
        end
      end
    end
  end
end
